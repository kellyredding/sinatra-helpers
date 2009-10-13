require 'openssl'
require 'net/smtp'
require 'tmail'
require 'sinatra/base'
require 'sinatra_helpers/mailer/exceptions'
require 'sinatra_helpers/mailer/tls'

module SinatraHelpers::Mailer
  class Base
    
    CONFIGS = [:server, :domain, :port, :reply_to, :username, :password, :authentication, :content_type, :charset]
    CONFIGS.each do |config|
      attr_reader config
    end
    attr_accessor :logger
    
    def initialize(configs={})
      CONFIGS.each do |config|
        instance_variable_set("@#{config}", configs[config])
      end
      @authentication ||= :login
      @reply_to ||= @username
      @content_type ||= 'text/plain'
      @charset ||= 'UTF-8'
      @logger = block_given? ? yield : nil
    end
    
    def send(settings={})
      check_configs
      [:to, :subject].each do |setting|
        raise SinatraHelpers::Mailer::SendError, "cannot send, #{setting} not specified." unless settings[setting]
      end
      mail = generate_mail(settings)
      mail.body = yield(mail) if block_given?
      mail.body ||= ''
      Sinatra::Application.environment.to_s == 'production' ? send_mail(mail) : log_mail(mail)
      log(:info, "Sent '#{mail.subject}' to #{mail.to.join(',')}")
      mail
    end
    
    protected
    
    def check_configs
      CONFIGS.each do |config|
        raise SinatraHelpers::Mailer::ConfigError, "#{config} not configured." unless instance_variable_get("@#{config}")
      end
    end
    
    def generate_mail(settings)
      mail = TMail::Mail.new
      mail.to = Array.new([settings[:to]])
      mail.from = @reply_to
      mail.reply_to = @reply_to
      mail.subject = settings[:subject]
      mail.date = Time.now
      mail.set_content_type @content_type
      mail.charset = @charset
      mail
    end
    
    def send_mail(mail)
      raise SinatraHelpers::Mailer::SendError, "cannot send, bad (or empty) mail object given." unless mail
      Net::SMTP.start(@server, @port, @domain, @username, @password, @authentication) do |server|
        mail.to.each {|recipient| server.send_message(mail.to_s, mail.from, recipient) }
      end
    end
    
    def log_mail(mail)
      log(:debug, mail.to_s)
    end
    
    def log(level, msg)
      if(msg)
        if @logger && @logger.respond_to?(level)
          @logger.send(level.to_s, msg) 
        else
          puts "** [#{level.to_s.upcase}]: [Mailer] #{msg}"
        end
      end
    end
    
  end
end

require 'erb'
require 'sinatra/base'
require "useful/erb_helpers/links"

module SinatraHelpers; end
module SinatraHelpers::Erb; end

module SinatraHelpers::Erb::Links
  
  SINATRA_HELPERS_LINKS_TMP_FILE = File.expand_path('./tmp/.sinatra_helpers_links')
  
  class << self
    
    def registered(app)
      app.send(:alias_method, :useful_stylesheet_link_tag, :stylesheet_link_tag)
      app.send(:alias_method, :stylesheet_link_tag, :sinatra_helpers_stylesheet_link_tag)

      app.send(:alias_method, :useful_javascript_include_tag, :javascript_include_tag)
      app.send(:alias_method, :javascript_include_tag, :sinatra_helpers_javascript_include_tag)
    end
    
  end

  def sinatra_helpers_stylesheet_link_tag(*args)
    useful_stylesheet_link_tag(sinatra_helpers_links_args(args))
  end
  
  def sinatra_helpers_javascript_include_tag(*args)
    useful_javascript_include_tag(sinatra_helpers_links_args(args))
  end
  
  private
  
  def sinatra_helpers_links_args(args)
    the_args = args.flatten
    if the_args.last && the_args.last.kind_of?(::Hash)
      the_args.last[:timestamp] ||= sinatra_helpers_links_timestamp
    else
      the_args << { :timestamp => sinatra_helpers_links_timestamp }
    end
    the_args
  end
  
  def sinatra_helpers_links_timestamp
    if defined?(:development?) && !development?
      unless File.exists?(SINATRA_HELPERS_LINKS_TMP_FILE)
        `touch #{SINATRA_HELPERS_LINKS_TMP_FILE}`
      end
      File.mtime(SINATRA_HELPERS_LINKS_TMP_FILE).to_i.to_s
    else
      Time.now.to_i.to_s
    end
  end

end

Sinatra::Application.helpers  Useful::ErbHelpers::Links
Sinatra::Application.helpers  SinatraHelpers::Erb::Links

Sinatra::Application.register SinatraHelpers::Erb::Links


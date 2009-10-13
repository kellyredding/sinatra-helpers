require 'sinatra/base'
require 'sinatra_helpers/erb/helpers.rb')

module SinatraHelpers::Erb::Tags
  
  include SinatraHelpers::Erb::Helpers
  
  def input_tag(type, name, value, options={}, &block)
    options[:tag] ||= :input
    options[:type] = type unless type.nil?
    unless name.nil?
      options[:name] = name 
      options[:id] ||= sinatra_erb_helper_safe_id(name)
    end
    options[:value] = value unless value.nil?
    tag(options.delete(:tag), options, &block)
  end

  def clear_tag(options={})
    options[:tag] ||= :div
    options[:style] ||= ''
    options[:style] = "clear: both;#{options[:style]}"
    tag(options.delete(:tag), options) { '' }
  end

  # helpers to escape tag text content
  include Rack::Utils
  alias_method :h, :escape_html
  
  # escape tag text content and format for text like display
  def h_text(text, opts={})
    h(text.to_s).
      gsub(/\r\n?/, "\n").  # \r\n and \r -> \n
      split("\n").collect do |line|
        line.nil? ? '': line.sub(/(\s+)?\S*/) {|lead| lead.gsub(/\s/,'&nbsp;')}
      end.join("\n"). # change any leading white spaces on a line to '&nbsp;'
      gsub(/\n/,'\1<br />') # newlines -> br added
  end

  # emulator for 'tag'
  # EX : tag :h1, "shizam", :title => "shizam"
  # => <h1 title="shizam">shizam</h1>
  def tag(name, options={})
    "<#{name.to_s} #{sinatra_erb_helper_hash_to_html_attrs(options)} #{block_given? ? ">#{yield}</#{name}" : "/"}>"
  end
  
end      

Sinatra::Application.helpers SinatraHelpers::Erb::Tags


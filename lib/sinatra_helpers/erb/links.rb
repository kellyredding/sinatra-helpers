require 'sinatra/base'
require 'sinatra_helpers/erb/tags')

module SinatraHelpers::Erb::Links
  
  # helper to emulate action view's 'link_to'
  # EX : link_to "google", "http://google.com"
  # => <a href="http://google.com">google</a>
  def link_to(content,href,options={})
    options.update :href => href
    tag(:a, options) { content }
  end
  
  def open_link_to(content, href, options={})
    options[:onclick] = "javascript: window.open('#{href}'); return false;"
    link_to(content, href, options)
  end

  def mail_link_to(email, options={})
    link_to options[:label] || email, "mailto: #{email}"
  end

  def link_to_function(content, function, opts={})
    opts ||= {}
    opts[:href] ||= 'javascript: void(0);'
    opts[:onclick] = "javascript: #{function}; return false;"
    link_to content, opts[:href], opts
  end

  # helper to emulate 'image_tag'
  # EX : image_tag 'logo.jpg'
  #  => <img src="images/logo.jpg" />
  def image_tag(src,options={})
    options[:src] = ['/'].include?(src[0..0]) ? src : "/images/#{src}"
    tag(:img, options)
  end

  # helper to emulate 'stylesheet_link_tag'
  # EX : stylesheet_link_tag 'default'
  #  => <link rel="stylesheet" href="/stylesheets/default.css" type="text/css" media="all" title="no title" charset="utf-8">
  def stylesheet_link_tag(srcs,options={})
    options[:media] ||=  "screen"
    options[:type] ||= "text/css"
    options[:rel] ||= "stylesheet"
    srcs.to_a.collect do |src|
      options[:href] = "/stylesheets/#{src}.css#{"?#{Time.now.to_i}" if Sinatra::Application.environment.to_s == 'development'}"
      tag(:link, options)
    end.join("\n")
  end

  # helper to emulate 'javascript_include_tag'
  # EX : javascript_include_tag 'app'
  #  => <script src="/js/app.js" type="text/javascript" />  
  # EX : javascript_include_tag ['app', 'jquery']
  #  => <script src="/js/app.js" type="text/javascript" />
  #  => <script src="/js/jquery.js" type="text/javascript" />
  def javascript_include_tag(srcs,options={})
    options[:type] ||= "text/javascript"
    srcs.to_a.collect do |src|
      options[:src] = "/javascripts/#{src}.js#{"?#{Time.now.to_i}" if Sinatra::Application.environment.to_s == 'development'}"
      tag(:script, options) { '' }
    end.join("\n")
  end

  # helper to emulate 'javascript_tag'
  def javascript_tag(options={})
    options[:type] ||= "text/javascript"
    tag(:script, options) { yield }
  end

end
  
Sinatra::Application.helpers SinatraHelpers::Erb::Links

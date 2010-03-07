begin
  require 'gemsconfig'
rescue LoadError => err
  puts " ** can't load gemsconfig.  gem install kelredd-gemsconfig **"
end

Gemsconfig::init do |config|
  
  config.gem 'rack-flash', :lib => 'rack-flash'
  config.gem 'rack-cache', :lib => false
  config.gem 'rack-less', :lib => 'rack/less'
  config.gem 'rack-sprockets', :lib => 'rack/sprockets'
    
  config.gem 'kelredd-useful', :lib => 'useful/ruby_extensions'
  config.gem 'kelredd-sinatra-helpers', :lib => 'sinatra_helpers'

end if defined?(Gemsconfig)

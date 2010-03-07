# basic app configurations
set :root, root_path
set :views, root_path("app", "views")
set :images_path, public_path("images")
set :environment, RACK_ENV.to_sym if defined?(RACK_ENV)

# load gems
require 'config/gems'
Gemsconfig::load if defined?(Gemsconfig)

# load app files
load_app 'helpers'
load_app 'models'

# TODO: set your session cookie name here
use Rack::Session::Cookie, :key => '_sess'
use Rack::Flash

use Rack::Less
Rack::Less.configure do |config|
  config.combinations = {
    'web' => ['reset', 'app']
  }
  config.compress = config.cache = production? 
end

use Rack::Sprockets
Rack::Sprockets.configure do |config|
  if config.cache = production? 
    config.compress = :whitespace
  end
end

require 'sinatra/base'
require 'sinatra_helpers/less'
require 'sinatra_helpers/sprockets'
 
class TestApp < Sinatra::Base
  
  configure do
    set :root, File.expand_path(File.dirname(__FILE__))
  end
  register SinatraHelpers::Less
  register SinatraHelpers::Sprockets
  
  # test action
  get '/test' do
    "this is a test"
  end

end
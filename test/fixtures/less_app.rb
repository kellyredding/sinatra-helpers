require 'sinatra/base'
require 'sinatra_helpers/less'
 
class LessApp < Sinatra::Base
  
  configure do
    set :root, File.expand_path(File.dirname(__FILE__))
  end
  register SinatraHelpers::Less
  
  # test action
  get '/test' do
    "this is a test"
  end

end
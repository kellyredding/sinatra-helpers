require 'sinatra/base'
 
class TestApp < Sinatra::Base
  
  configure do
    set :root, File.expand_path(File.dirname(__FILE__))
  end
  
  # test action
  get '/test' do
    "this is a test"
  end

end
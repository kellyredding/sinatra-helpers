require 'sinatra/base'

module SinatraHelpers::EnvironmentTests
    
  def production? 
    Sinatra::Application.environment.to_s == 'production'
  end
  def development?
    Sinatra::Application.environment.to_s == 'development'
  end
  
end

Sinatra::Application.helpers SinatraHelpers::EnvironmentTests
Sinatra::Application.register SinatraHelpers::EnvironmentTests

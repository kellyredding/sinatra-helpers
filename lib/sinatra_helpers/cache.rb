require 'sinatra/base'

module SinatraHelpers; end
module SinatraHelpers::Cache
    
  def cache_for(time_in_secs)
    if production?
      headers['Cache-Control'] = "public, max-age=#{time_in_secs}"
    end
  end
  
end

Sinatra::Application.helpers SinatraHelpers::Cache
Sinatra::Application.register SinatraHelpers::Cache

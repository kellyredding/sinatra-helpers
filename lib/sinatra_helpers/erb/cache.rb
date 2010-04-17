require 'erb'
require 'sinatra/base'

module SinatraHelpers; end
module SinatraHelpers::Erb; end

module SinatraHelpers::Erb::Cache
  
  def cache_for(time_in_secs)
    if production?
      headers['Cache-Control'] = "public, max-age=#{time_in_secs}"
    end
  end
  
end
  
Sinatra::Application.helpers SinatraHelpers::Erb::Cache


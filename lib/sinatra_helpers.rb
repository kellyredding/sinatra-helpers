require 'sinatra_helpers/environment_tests'
require 'sinatra_helpers/erb'

module SinatraHelpers

  HTTP_STATUS = {
    :not_found => 404,
    :ok => 200
  }

  class << self
    
    def page_cache?(app)
      if defined?(Rails)
        Rails.configuration.action_controller.perform_caching
      elsif app.respond_to?(:environment)
        app.environment == 'production'
      else
        false
      end
    end
    
  end
end
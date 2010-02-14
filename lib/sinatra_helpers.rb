require 'sinatra_helpers/environment_tests'
require 'sinatra_helpers/erb'

module SinatraHelpers

  class << self
    
    def page_cache?(app)
      if defined?(Rails)
        Rails.configuration.action_controller.perform_caching
      elsif app.respond_to?(:environment)
        app.environment.to_s == 'production'
      else
        false
      end
    end
    
  end
end
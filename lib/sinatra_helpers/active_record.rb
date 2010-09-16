require 'sinatra/base'
require 'active_record'

module SinatraHelpers; end
module SinatraHelpers::ActiveRecord

  class << self

    def registered(app)
      db_config_file = File.join(Sinatra::Application.root,'config',"database.yml")
      db_config = YAML.load(ERB.new(IO.read(db_config_file)).result)
      db = (db_config[Sinatra::Application.environment.to_s]).symbolize_keys
      ::ActiveRecord::Base.establish_connection(db)
      ::ActiveRecord::Base.logger = Logger.new(STDOUT)
    end

  end

end

Sinatra::Application.register SinatraHelpers::ActiveRecord

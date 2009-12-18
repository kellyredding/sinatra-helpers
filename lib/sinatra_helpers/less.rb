begin
  require 'less'
rescue LoadError => err
  err.message << "\n**** Install less (sudo gem install less) to use the sinatra less helper ****\n"
  raise err
end

module SinatraHelpers; end
module SinatraHelpers::Less
  
  CONFIG_DEFAULTS = {
    :hosted_path => '/stylesheets',
    :src_path => 'app/stylesheets',
    :cache_name => 'all',
    :stylesheets => []
  }
  
  HTTP_STATUS = {
    :not_found => 404,
    :ok => 200
  }

  class << self
    attr_reader :app
    attr_accessor :hosted_path, :src_path, :stylesheets, :cache_name
    
    def [](config)
      instance_variable_get("@#{config}") || CONFIG_DEFAULTS[config]
    end
  
    def registered(app)
      instance_variable_set("@app", app)
      app.get "#{SinatraHelpers::Less[:hosted_path]}/*.css" do
        css_name = params['splat'].first.to_s
        less_path = File.join([
          app.root, SinatraHelpers::Less[:src_path], "#{css_name}.less"
        ])
        content_type :css
        if File.exists?(less_path)
          SinatraHelpers::Less.compile(css_name, [less_path])
        elsif SinatraHelpers::Less[:cache_name] && css_name == SinatraHelpers::Less[:cache_name]
          less_paths = SinatraHelpers::Less[:stylesheets].collect do |css_name|
            File.join(app.root, SinatraHelpers::Less[:src_path], "#{css_name}.less")
          end.select do |less_path|
            File.exists?(less_path)
          end
          SinatraHelpers::Less.compile(css_name, less_paths)
        else
          halt HTTP_STATUS[:not_found]
        end
      end    
    end
    
    def page_cache?
      if defined?(Rails)
        Rails.configuration.action_controller.perform_caching
      else
        app.environment == 'production'
      end
    end
    
    def compile(css_name, file_paths)
      compiled_less = file_paths.collect do |file_path|
        Less::Engine.new(File.new(file_path)).to_css
      end.join("\n")
      if page_cache?
        pub_path = File.join(SinatraHelpers::Less.app.public, SinatraHelpers::Less[:hosted_path])
        FileUtils.mkdir_p(pub_path)
        hosted = File.join(pub_path, "#{css_name}.css")
        File.open(hosted, "w") do |file|
          file.write(compiled_less)
        end
      end
      compiled_less
    end

  end
  
end

begin
  require 'sprockets'
rescue LoadError => err
  err.message << "\n**** Install sprockets (gem install sprockets) to use the sinatra sprockets helpers ****\n"
  raise err
end

module SinatraHelpers; end
module SinatraHelpers::Sprockets
  
  CONTENT_TYPE = "text/javascript; charset=utf-8"

  class Config
    ATTRIBUTES = [:hosted_root, :src_root, :load_path, :expand_paths, :cache_control]
    DEFAULTS = {
      :hosted_root => '/javascripts',
      :src_root => 'app/javascripts',
      :load_path => ['app/javascripts/**', 'vendor/javascripts', 'vendor/sprockets'],
      :expand_paths => true,
      :cache_control => SinatraHelpers::DEFAULT_CACHE_CONTROL
    }

    attr_accessor *ATTRIBUTES
    
    def initialize(args={})
      ATTRIBUTES.each do |a|
        instance_variable_set("@#{a}", args[a] || DEFAULTS[a])
      end
    end
  end

  class << self
    attr_reader :app
    
    def config
      if instance_variable_get("@config").nil?
        instance_variable_set("@config", SinatraHelpers::Sprockets::Config.new)
      end
      yield instance_variable_get("@config") if block_given?
      instance_variable_get("@config")
    end
    
    def secretary
      if instance_variable_get("@secretary").nil?
        instance_variable_set("@secretary", {
          :root => app.root,
          :load_path => config.load_path,
          :expand_paths => config.expand_paths
        })
      end
      yield instance_variable_get("@secretary") if block_given?
      instance_variable_get("@secretary")      
    end
    
    def [](config_attribute)
      config.send(config_attribute)
    end
  
    def registered(app)
      instance_variable_set("@app", app)

      app.get "/sprockets-sinatra-helper-test" do
        if SinatraHelpers::Sprockets.config
          "The sprockets sinatra helper is configured and ready :)"
        else
          "The sprockets sinatra helper is NOT configured and ready :("
        end
      end
      
      app.get "#{SinatraHelpers::Sprockets[:hosted_root]}/*.js" do
        src_name = params['splat'].first.to_s
        src_file_path = File.join([
          SinatraHelpers::Sprockets[:src_root], "#{src_name}.js"
        ])
        src_path = File.join(app.root, src_file_path)

        content_type CONTENT_TYPE
        if SinatraHelpers.page_cache?(SinatraHelpers::Sprockets.app)
          headers['Cache-Control'] = SinatraHelpers::Sprockets[:cache_control]
        end

        if File.exists?(src_path)
          SinatraHelpers::Sprockets.compile(src_file_path)
        else
          halt SinatraHelpers::HTTP_STATUS[:not_found]
        end
      end    
    end
    
    def compile(src_file_name)
      secretary_params = SinatraHelpers::Sprockets.secretary do |params|
        params[:source_files] = [src_file_name]
      end
      compiled_src = Sprockets::Secretary.new(secretary_params).concatenation.to_s
      if SinatraHelpers.page_cache?(SinatraHelpers::Sprockets.app)
        pub_path = File.join(SinatraHelpers::Sprockets.app.public, SinatraHelpers::Sprockets[:hosted_root])
        FileUtils.mkdir_p(pub_path)
        hosted = File.join(pub_path, File.basename(src_file_name))
        File.open(hosted, "w") do |file|
          file.write(compiled_src)
        end
      end
      compiled_src
    end
    
  end

end
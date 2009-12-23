begin
  require 'less'
rescue LoadError => err
  err.message << "\n**** Install less (gem install less) to use the sinatra less helpers ****\n"
  raise err
end

module SinatraHelpers; end
module SinatraHelpers::Less
  
  CONTENT_TYPE = "text/css"
  DEFAULT_CACHE_CONTROL = 'public, max-age=86400' # cache for 24 hours
  
  class Config
    ATTRIBUTES = [:hosted_root, :src_root, :stylesheets, :cache_name, :cache_control, :compression]
    DEFAULTS = {
      :hosted_root => '/stylesheets',
      :src_root => 'app/stylesheets',
      :cache_name => 'all',
      :stylesheets => [],
      :cache_control => DEFAULT_CACHE_CONTROL,
      :compression => false
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
        instance_variable_set("@config", SinatraHelpers::Less::Config.new)
      end
      yield instance_variable_get("@config") if block_given?
      instance_variable_get("@config")
    end
    
    def [](config_attribute)
      config.send(config_attribute)
    end
  
    def registered(app)
      instance_variable_set("@app", app)

      app.get "/less-sinatra-helper-test" do
        if SinatraHelpers::Less.config
          "The LESS sinatra helper is configured and ready :)"
        else
          "The LESS sinatra helper is NOT configured and ready :("
        end
      end

      app.get "#{SinatraHelpers::Less[:hosted_root]}/*.css" do
        css_name = params['splat'].first.to_s
        less_path = File.join([
          app.root, SinatraHelpers::Less[:src_root], "#{css_name}.less"
        ])
        css_path = File.join([
          app.root, SinatraHelpers::Less[:src_root], "#{css_name}.css"
        ])

        content_type CONTENT_TYPE
        if SinatraHelpers.page_cache?(SinatraHelpers::Less.app)
          headers['Cache-Control'] = SinatraHelpers::Less[:cache_control]
        end

        if File.exists?(less_path)
          SinatraHelpers::Less.compile(css_name, [less_path])
        elsif File.exists?(css_path)
          SinatraHelpers::Less.compile(css_name, [css_path])
        elsif SinatraHelpers::Less[:cache_name] && css_name == SinatraHelpers::Less[:cache_name]
          less_paths = SinatraHelpers::Less[:stylesheets].collect do |css_name|
            File.join(app.root, SinatraHelpers::Less[:src_root], "#{css_name}.less")
          end.select do |less_path|
            File.exists?(less_path)
          end
          SinatraHelpers::Less.compile(css_name, less_paths)
        else
          halt SinatraHelpers::HTTP_STATUS[:not_found]
        end
      end    
    end
    
    def compile(css_name, file_paths)
      compiled_less = file_paths.collect do |file_path|
        Less::Engine.new(File.new(file_path)).to_css
      end.join("\n")
      compiled_less.delete!("\n") if use_compression?
      if SinatraHelpers.page_cache?(SinatraHelpers::Less.app)
        pub_path = File.join(SinatraHelpers::Less.app.public, SinatraHelpers::Less[:hosted_root])
        FileUtils.mkdir_p(pub_path)
        hosted = File.join(pub_path, "#{css_name}.css")
        File.open(hosted, "w") do |file|
          file.write(compiled_less)
        end
      end
      compiled_less
    end
    
    def use_compression?
      SinatraHelpers::Less[:compression]
    end

  end
  
end

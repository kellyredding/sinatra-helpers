begin
  require 'less'
rescue LoadError => err
  err.message << "\n**** Install less (gem install less) to use the sinatra less helpers ****\n"
  raise err
end

require 'sinatra_helpers/less/config'

module SinatraHelpers; end
module SinatraHelpers::Less
  
  CONTENT_TYPE = "text/css"
  
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
        file_name = params['splat'].first.to_s
        less_path = File.join([
          app.root, SinatraHelpers::Less[:src_root], "#{file_name}.less"
        ])
        css_path = File.join([
          app.root, SinatraHelpers::Less[:src_root], "#{file_name}.css"
        ])

        content_type CONTENT_TYPE

        if File.exists?(less_path)
          SinatraHelpers::Less.compile(file_name, [less_path])
        elsif File.exists?(css_path)
          SinatraHelpers::Less.compile(file_name, [css_path])
        elsif SinatraHelpers::Less[:concat].include?(file_name)
          less_paths = SinatraHelpers::Less[:concat][file_name].collect do |concat_name|
            File.join(app.root, SinatraHelpers::Less[:src_root], "#{concat_name}.less")
          end.select do |less_path|
            File.exists?(less_path)
          end
          SinatraHelpers::Less.compile(file_name, less_paths)
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
      SinatraHelpers::Less[:compress]
    end

  end
  
end

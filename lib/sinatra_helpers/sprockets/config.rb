module SinatraHelpers; end
module SinatraHelpers::Sprockets

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

end
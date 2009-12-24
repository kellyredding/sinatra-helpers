module SinatraHelpers; end
module SinatraHelpers::Less

  class Config
    ATTRIBUTES = [:hosted_root, :src_root, :concat, :cache_control, :compression]
    DEFAULTS = {
      :hosted_root => '/stylesheets',
      :src_root => 'app/stylesheets',
      :concat => {},
      :cache_control => SinatraHelpers::DEFAULT_CACHE_CONTROL,
      :compression => false
    }

    attr_accessor *ATTRIBUTES
    
    def initialize(args={})
      ATTRIBUTES.each do |a|
        instance_variable_set("@#{a}", args[a] || DEFAULTS[a])
      end
    end
  end
  
end
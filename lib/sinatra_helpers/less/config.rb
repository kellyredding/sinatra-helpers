module SinatraHelpers; end
module SinatraHelpers::Less

  class Config
    ATTRIBUTES = [:hosted_root, :src_root, :concat, :compress]
    DEFAULTS = {
      :hosted_root => '/stylesheets',
      :src_root => 'app/stylesheets',
      :concat => {},
      :compress => false
    }

    attr_accessor *ATTRIBUTES
    
    def initialize(args={})
      ATTRIBUTES.each do |a|
        instance_variable_set("@#{a}", args[a] || DEFAULTS[a])
      end
    end
  end
  
end
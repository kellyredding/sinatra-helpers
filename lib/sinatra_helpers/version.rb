module SinatraHelpers
  module Version
    
    MAJOR = 0
    MINOR = 1
    TINY  = 9
    
    def self.to_s # :nodoc:
      [MAJOR, MINOR, TINY].join('.')
    end
    
  end
end
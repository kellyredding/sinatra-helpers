require "sinatra_helpers/erb"
require 'useful/ruby_extensions/object' unless ::Object.new.respond_to?('blank?')

module SinatraHelpers; end
module SinatraHelpers::Less

  module Erb
    
    def less_link_tag(*args)
      the_args = args.flatten
      srcs, options = if the_args.last && the_args.last.kind_of?(::Hash)
        [the_args[0..-2], the_args.last]
      else
        [the_args, {}]
      end
      
      options[:environment] ||= SinatraHelpers::Less.app.environment.to_s
      
      concat = options.delete(:concat)
      if concat && !(concat.to_s).blank?
        SinatraHelpers::Less.config do |config|
          config.concat[concat.to_s] = srcs
        end
        srcs = concat.to_s if SinatraHelpers.page_cache?(SinatraHelpers::Less.app) 
      end
        
      stylesheet_link_tag srcs, options
    end

  end


end
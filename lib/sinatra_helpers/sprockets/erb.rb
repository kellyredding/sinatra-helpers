require "sinatra_helpers/erb"
require 'useful/ruby_extensions/object' unless ::Object.new.respond_to?('blank?')

module SinatraHelpers; end
module SinatraHelpers::Sprockets

  module Erb
    
    def sprockets_include_tag(*args)
      the_args = args.flatten
      srcs, options = if the_args.last && the_args.last.kind_of?(::Hash)
        [the_args[0..-2], the_args.last]
      else
        [the_args, {}]
      end
      
      options[:environment] ||= SinatraHelpers::Sprockets.app.environment.to_s
      
      javascript_include_tag srcs, options
    end

  end

end
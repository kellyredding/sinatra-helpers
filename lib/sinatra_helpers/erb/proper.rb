require 'erb'
require 'sinatra/base'
require "useful/erb_helpers/proper"

module SinatraHelpers; end
module SinatraHelpers::Erb; end

Sinatra::Application.helpers Useful::ErbHelpers::Proper


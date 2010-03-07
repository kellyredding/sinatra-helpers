require 'erb'
require 'sinatra/base'
require "useful/erb_helpers/forms"

module SinatraHelpers; end
module SinatraHelpers::Erb; end

Sinatra::Application.helpers Useful::ErbHelpers::Forms

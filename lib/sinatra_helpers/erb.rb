Dir[File.join(File.dirname(__FILE__), "erb" ,"*.rb")].each do |file|
  require "sinatra_helpers/erb/#{File.basename(file, ".rb")}"
end

require "useful/erb_helpers"
Sinatra::Application.helpers Useful::ErbHelpers::Tags
Sinatra::Application.helpers Useful::ErbHelpers::Links
Sinatra::Application.helpers Useful::ErbHelpers::Forms
Sinatra::Application.helpers Useful::ErbHelpers::Proper

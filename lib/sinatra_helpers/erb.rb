require "useful/erb_helpers"

Dir[File.join(File.dirname(__FILE__), "erb" ,"*.rb")].each do |file|
  require "sinatra_helpers/erb/#{File.basename(file, ".rb")}"
end


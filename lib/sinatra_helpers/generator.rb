Dir[File.join(File.dirname(__FILE__), "generator" ,"*.rb")].each do |file|
  require "sinatra_helpers/generator/#{File.basename(file, ".rb")}"
end

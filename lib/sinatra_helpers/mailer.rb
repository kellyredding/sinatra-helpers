module SinatraHelpers::Mailer; end
Dir[File.join(File.dirname(__FILE__), "mailer" ,"*.rb")].each do |file|
  require "sinatra_helpers/mailer/#{File.basename(file, ".rb")}"
end

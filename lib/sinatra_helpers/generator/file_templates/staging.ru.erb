RACK_ENV = ENV["RACK_ENV"] ||= "staging" unless defined? RACK_ENV
require 'app'
set :app_file, File.join(root_path, 'app.rb')
disable :run

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/#{RACK_ENV.downcase}.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
require 'rubygems'
require 'rake/testtask'

$LOAD_PATH.unshift(File.expand_path("#{File.dirname(__FILE__)}"))

Dir[File.expand_path('../lib/tasks/*.rake', __FILE__)].each do |file|
  load file
end

namespace :test do

  Rake::TestTask.new(:units) do |t|
    t.libs << "test"
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:units'].comment = "Run the unit tests"

  Rake::TestTask.new(:app) do |t|
    t.libs << "test"
    t.pattern = 'test/functional/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:app'].comment = "Run the functional tests"

end

require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

require 'lib/sinatra_helpers/version'

spec = Gem::Specification.new do |s|
  s.name             = 'kelredd-sinatra-helpers'
  s.version          = SinatraHelpers::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "a ruby gem with a bunch of helpers to make Sinatra more useful"
  s.author           = 'Kelly Redding'
  s.email            = 'kelly@kelredd.com'
  s.homepage         = 'http://github.com/kelredd/sinatra-helpers'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib}/**/*")
  # s.executables    = ['sinatra-helpers']
  
  s.add_dependency('kelredd-useful', '>= 0.2.0')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

begin
  require 'rcov/rcovtask'

  Rcov::RcovTask.new(:coverage) do |t|
    t.libs       = ['test']
    t.test_files = FileList["test/**/*_test.rb"]
    t.verbose    = true
    t.rcov_opts  = ['--text-report', "-x #{Gem.path}", '-x /Library/Ruby', '-x /usr/lib/ruby']
  end
  
  task :default => :coverage
  
rescue LoadError
  warn "\n**** Install rcov (sudo gem install relevance-rcov) to get coverage stats ****\n"
  task :default => :test
end


desc 'Generate the gemspec to serve this gem'
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "test/features --format pretty" 
end

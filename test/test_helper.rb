require 'rubygems'
require 'test/unit'
require 'shoulda/test_unit'
require 'useful/shoulda_macros/test_unit'
require 'rack/test'
require 'webrat'

lib_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)
require 'sinatra_helpers'

$LOAD_PATH.unshift(File.dirname(__FILE__))

class Test::Unit::TestCase
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
 
  Webrat.configure do |config|
    config.mode = :rack
  end
 
end
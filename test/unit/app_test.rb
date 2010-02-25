require "#{File.dirname(__FILE__)}/../test_helper"
require 'fixtures/test_app'

class LessTest < Test::Unit::TestCase

  def app
    @app ||= TestApp
  end

  context "A SinatraHelpers app" do
    setup do
      app.set :environment, :development
    end

    context "in testing" do
      setup do
        app.set :environment, :test
        visit '/test'
      end
      
      should "should work" do
        assert_contain("this is a test")
      end
    end
  end

end
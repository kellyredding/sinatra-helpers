require 'test_helper'

class LayoutTest < Test::Unit::TestCase

  def app
    Sinatra::Application
  end

  context "The app's layout" do
  
    before do
      visit '/'
    end


    # TODO: write better tests...
    # => this is just for show :)
    
    should "say hello" do
      assert_contain "Hello from An-app!"
    end
    
  end

end
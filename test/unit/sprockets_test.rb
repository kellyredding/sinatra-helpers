require 'test_helper'
require 'fixtures/test_app'

class SprocketsTest < Test::Unit::TestCase

  def app
    @app ||= TestApp
  end

  context "A SinatraHelpers::Sprockets app" do
    setup do
      app.set :environment, :development
    end

    context "in testing" do
      setup do
        app.set :environment, :test
        visit '/sprockets-sinatra-helper-test'
      end
      
      should "should work" do
        assert_contain("The sprockets sinatra helper is configured and ready :)")
      end
    end    
  end

  context "when a non existing script is requested" do
    setup do
      @response = visit "#{SinatraHelpers::Sprockets[:hosted_root]}/does_not_exist.js"
    end
    
    should "should return Not Found" do
      assert_equal SinatraHelpers::HTTP_STATUS[:not_found], @response.status
    end      
  end
  
  context "when requesting a script needing to be compiled" do
    setup do
      @script_name = "raw.js"
      @compiled = File.open(File.join(app.root, SinatraHelpers::Sprockets[:src_root], "compiled.js")) do |file|
        file.read
      end
      @response = visit "#{SinatraHelpers::Sprockets[:hosted_root]}/#{@script_name}"
    end
    
    should "return compiled sprockets script" do
      assert_equal SinatraHelpers::HTTP_STATUS[:ok], @response.status
      assert_equal SinatraHelpers::Sprockets::CONTENT_TYPE, @response.headers["Content-Type"]
      assert_equal @compiled.strip, @response.body.strip
    end
    
    context "in production" do
      setup do
        app.set :environment, "production"
        @response = visit "#{SinatraHelpers::Sprockets[:hosted_root]}/#{@script_name}"
      end

      should "page cache the compiled css to a public file" do
        assert_equal SinatraHelpers::Sprockets::DEFAULT_CACHE_CONTROL, @response.headers['Cache-Control']
        pub_path = File.join(app.public, SinatraHelpers::Sprockets[:hosted_root])
        assert File.exists?(pub_path)
        cached_file = File.join(pub_path, @script_name)
        assert File.exists?(cached_file)
        cached_compiled = File.open(cached_file) do |file|
          file.read
        end
        assert_equal @compiled.strip, cached_compiled.strip
      end
    end
    
  end
  
end
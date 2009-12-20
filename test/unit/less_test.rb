require 'test_helper'
require 'fixtures/test_app'

class LessTest < Test::Unit::TestCase

  def app
    @app ||= TestApp
  end

  context "A SinatraHelpers::Less app" do
    setup do
      app.set :environment, :development
    end

    context "in testing" do
      setup do
        app.set :environment, :test
        visit '/less-sinatra-helper-test'
      end
      
      should "should work" do
        assert_contain("The LESS sinatra helper is configured and ready :)")
      end
    end
    
    context "when a non existing stylesheet is requested" do
      setup do
        @response = visit "#{SinatraHelpers::Less[:hosted_root]}/does_not_exist.css"
      end
      
      should "should return Not Found" do
        assert_equal SinatraHelpers::HTTP_STATUS[:not_found], @response.status
      end      
    end
    
    context "when requesting a stylesheet needing to be compiled" do
      setup do
        @css_name = "raw.css"
        @compiled = File.open(File.join(app.root, SinatraHelpers::Less[:src_root], "compiled.css")) do |file|
          file.read
        end
        @response = visit "#{SinatraHelpers::Less[:hosted_root]}/#{@css_name}"
      end
      
      should "return compiled LESS" do
        assert_equal SinatraHelpers::HTTP_STATUS[:ok], @response.status
        assert_equal SinatraHelpers::Less::CONTENT_TYPE, @response.headers["Content-Type"]
        assert_equal @compiled.strip, @response.body.strip
      end
      
      context "in production" do
        setup do
          app.set :environment, "production"
          @response = visit "#{SinatraHelpers::Less[:hosted_root]}/#{@css_name}"
        end

        should "page cache the compiled css to a public file" do
          pub_path = File.join(app.public, SinatraHelpers::Less[:hosted_root])
          assert File.exists?(pub_path)
          cached_file = File.join(pub_path, @css_name)
          assert File.exists?(cached_file)
          cached_compiled = File.open(cached_file) do |file|
            file.read
          end
          assert_equal @compiled.strip, cached_compiled.strip
        end
      end
      
    end
    
    context "when requesting a stylesheet not needing to be compiled" do
      setup do
        @normal = File.open(File.join(app.root, SinatraHelpers::Less[:src_root], 'normal.css')) do |file|
          file.read
        end
        @response = visit "#{SinatraHelpers::Less[:hosted_root]}/normal.css"
      end
      
      should "return compiled LESS" do
        assert_equal @normal.strip, @response.body.strip
      end
    end
    
    context "when requesting many stylesheets needing to be compiled into one" do
      setup do
        SinatraHelpers::Less.config do |config|
          config.stylesheets = @the_stylesheets = ['one', 'two']
          config.cache_name = @the_cache_name = 'all'
        end
        @all = File.open(File.join(app.root, SinatraHelpers::Less[:src_root], 'all.css')) do |file|
          file.read
        end
        @response = visit "#{SinatraHelpers::Less[:hosted_root]}/all.css"
      end
      
      should "return compiled LESS" do
        assert_equal @the_stylesheets, SinatraHelpers::Less[:stylesheets]
        assert_equal @the_cache_name, SinatraHelpers::Less[:cache_name]
        assert_equal @all.strip, @response.body.strip
      end
    end
    
  end

end
require File.dirname(__FILE__) + '/../test_helper'

class GeneratorTest < Test::Unit::TestCase

  context "a structured sinatra app" do
    before do
      @tmp_dir = File.dirname(__FILE__) + "/../../tmp"
      FileUtils.mkdir_p(File.expand_path(@tmp_dir))
      @root_path = @tmp_dir
    end
    
    should "clean up bad app names" do
      {
        'app' => 'app', 'an-app' => 'an-app', 'an_app' => 'an_app',
        'anApp' => 'an-app', 'AnApp' => 'an-app', 'ANAPP' => 'anapp'
      }.each do |k,v|
        assert_equal v, SinatraHelpers::Generator::App.new(File.join(@tmp_dir, k)).name
      end
    end
    
    should_have_directories
    
    context "when generated" do 
    
      before do
        @name = "an-app"
        @root_path = File.join(@tmp_dir, @name)
        SinatraHelpers::Generator::App.new(@root_path).generate
      end
      
      should_have_files 'app.rb', 'Capfile', 'Rakefile'
      should_have_directories 'app'
      should_have_directories 'app/controllers'
      should_have_files       'app/controllers/app.rb'
      should_have_directories 'app/helpers'
      should_have_files       'app/helpers/app_helpers.rb'
      should_have_directories 'app/javascripts'
      should_have_files       'app/javascripts/app.js'
      should_have_directories 'app/models'
      should_have_directories 'app/stylesheets'
      should_have_directories 'app/views'
      should_have_files       'app/views/layout.erb'
      should_have_directories 'app/views/app'
      should_have_files       'app/views/app/index.html.erb'
    
      after do
        FileUtils.rm_rf(@tmp_dir)
      end

    end

  end
end
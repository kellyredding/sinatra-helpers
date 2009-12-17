require 'test_helper'
require 'sinatra_helpers/generator'

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
      
      should_have_files 'app.rb', 'Capfile', 'Rakefile', '.gitignore'
      
      should_have_directories 'admin'
      should_have_files       'admin/production.ru'
      should_have_directories 'admin/vhosts'
      should_have_directories 'admin/logrotate'
      
      should_have_directories 'javascripts'
      should_have_files       'javascripts/app.js'
      should_have_directories 'models'
      should_have_directories 'stylesheets'
      should_have_files       'stylesheets/reset.less'
      should_have_directories 'views'
      should_have_files       'views/layout.erb'
    
      should_have_directories 'config'
      should_have_files       'config/boot.rb'
      should_have_files       'config/deploy.rb'
      should_have_directories 'config/deploy'
      should_have_files       'config/deploy/production.rb'
      should_have_files       'config/deploy/staging.rb'
      should_have_files       'config/gems.rb'
      should_have_files       'config/sprockets.yml'

      should_have_directories 'log'

      should_have_directories 'public'
      should_have_directories 'public/images'

      context "when tested and done" do
        after do
          FileUtils.rm_rf(@tmp_dir)
        end
        
        should "cleanup after itself" do
          assert true
        end

      end

    end

  end
end
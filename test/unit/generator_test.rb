require "#{File.dirname(__FILE__)}/../test_helper"
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
        'anApp' => 'an-app', 'AnApp' => 'an-app', 'ANAPP' => 'anapp',
        'app.com' => 'app'

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

      should_have_files 'app.rb', 'Capfile', 'Rakefile', '.gitignore', 'config.ru'

      should_have_directories 'admin'
      should_have_files       'admin/production.ru'
      should_have_files       'admin/staging.ru'

      should_have_files       'app/base.rb'
      should_have_directories 'app/helpers'
      should_have_directories 'app/models'
      should_have_directories 'app/views'
      should_have_files       'app/views/layout.erb'
      should_have_files       'app/views/index.html.erb'
      should_have_directories 'app/stylesheets'
      should_have_directories 'app/javascripts'
      should_have_files       'app/javascripts/app.js'
      should_have_files       'app/stylesheets/reset.less'
      should_have_files       'app/stylesheets/reset-fonts.less'
      should_have_files       'app/stylesheets/app.less'

      should_have_directories 'config'
      should_have_files       'config/deploy.rb'
      should_have_directories 'config/deploy'
      should_have_files       'config/deploy/production.rb'
      should_have_files       'config/deploy/staging.rb'
      should_have_files       'config/env.rb'
      should_have_files       'config/gems.rb'
      should_have_files       'config/init.rb'

      should_have_directories 'lib'
      should_have_directories 'lib/tasks'
      should_have_files 'lib/tasks/environment.rake'

      should_have_directories 'log'

      should_have_directories 'public'
      should_have_directories 'public/images'

      should_have_directories 'script'
      should_have_files 'script/console'

      should_have_directories 'test'
      should_have_files       'test/test_helper.rb'
      should_have_directories 'test/functional'
      should_have_files       'test/functional/layout_test.rb'
      should_have_directories 'test/unit'
      should_have_files       'test/unit/model_test.rb'

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
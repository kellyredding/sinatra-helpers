module SinatraHelpers; end

module SinatraHelpers::Generator

  TEMPLATE = {
    'app.rb.erb' => 'app.rb',
    'config.ru.erb' => 'config.ru',
    'Capfile.erb' => 'Capfile',
    'Rakefile.erb' => 'Rakefile',
    'gitignore.erb' => '.gitignore',

    :admin => {
      'production.ru.erb' => 'production.ru',
      'staging.ru.erb' => 'staging.ru'
    },

    :app => {
      'base.rb.erb' => 'base.rb',
      :helpers => {},
      :models => {},
      :views => {
        'layout' => 'layout.erb',
        'index.html.erb.erb' => 'index.html.erb'
      },
      :javascripts => {
        'app.js.erb' => 'app.js'
      },
      :stylesheets => {
        'reset.less.erb' => 'reset.less',
        'reset-fonts.less.erb' => 'reset-fonts.less',
        'app.less.erb' => 'app.less'
      }
    },

    :config => {
      'deploy.rb.erb' => 'deploy.rb',
      :deploy => {
        'deploy_production.rb.erb' => 'production.rb',
        'deploy_staging.rb.erb' => 'staging.rb'
      },
      'env.rb.erb' => 'env.rb',
      'gems.rb.erb' => 'gems.rb',
      'init.rb.erb' => 'init.rb'
    },

    :lib => {
      :tasks => {
        'environment.rake.erb' => 'environment.rake'
      }
    },

    :log => {},

    :public => {
      :images => {},
    },

    :script => {
      'console.erb' => 'console'
    },

    :test => {
      'test_helper.rb.erb' => 'test_helper.rb',
      :functional => {
        'layout_test.rb.erb' => 'layout_test.rb'
      },
      :unit => {
        'model_test.rb.erb' => 'model_test.rb'
      }
    }

  }

end
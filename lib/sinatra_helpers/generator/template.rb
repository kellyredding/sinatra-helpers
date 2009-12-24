module SinatraHelpers; end

module SinatraHelpers::Generator

  TEMPLATE = {
    'app.rb.erb' => 'app.rb',
    'Capfile.erb' => 'Capfile',
    'Rakefile.erb' => 'Rakefile',
    'gitignore.erb' => '.gitignore',
    
    :admin => {
      'production.ru.erb' => 'production.ru',
      :vhosts => {},
      :logrotate => {}
    },
    
    :app => {
      :javascripts => {
        'app.js.erb' => 'app.js'
      },
      :models => {},
      :stylesheets => {
        'reset.less.erb' => 'reset.less',
        'app.less.erb' => 'app.less'
      },
      :views => {
        'layout' => 'layout.erb',
        'index.html.erb.erb' => 'index.html.erb'
      },
    },
    
    :config => {
      'boot.rb.erb' => 'boot.rb',
      'deploy.rb.erb' => 'deploy.rb',
      :deploy => {
        'deploy_production.rb.erb' => 'production.rb',
        'deploy_staging.rb.erb' => 'staging.rb'
      },
      'env.rb.erb' => 'env.rb',
      :envs => {
        'env_development.rb.erb' => 'development.rb',
        'env_test.rb.erb' => 'test.rb',
        'env_production.rb.erb' => 'production.rb'
      },
      'gems.rb.erb' => 'gems.rb'
    },
    
    :log => {},
    
    :public => {
      :images => {},
    },
    
    :script => {
      'console.erb' => 'console',
      'server.erb' => 'server'
    },
    
    :test => {
      'test_helper.rb.erb' => 'test_helper.rb',
      :functional => {
        'app_test.rb.erb' => 'app_test.rb'
      },
      :unit => {
        'model_test.rb.erb' => 'model_test.rb'
      }
    }
    
  }

end
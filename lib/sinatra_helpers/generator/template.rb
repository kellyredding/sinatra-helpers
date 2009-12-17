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
    
    :javascripts => {
      'app.js.erb' => 'app.js'
    },
    :models => {},
    :stylesheets => {
      'reset.less.erb' => 'reset.less',
      'web.less.erb' => 'web.less'
    },
    :views => {
      'layout' => 'layout.erb'
    },
    
    :config => {
      'boot.rb.erb' => 'boot.rb',
      :deploy => {
        'deploy_production.rb.erb' => 'production.rb',
        'deploy_staging.rb.erb' => 'staging.rb'
      },
      'deploy.rb.erb' => 'deploy.rb',
      'gems.rb.erb' => 'gems.rb',
      'sprockets.yml.erb' => 'sprockets.yml'
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
      :unit => {
        'unit_test.rb.erb' => 'unit_test.rb'
      }
    }
    
  }

end
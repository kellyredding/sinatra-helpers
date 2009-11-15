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
      :controllers => {
        'app_controller.rb.erb' => 'app.rb'
      },
      :helpers => {
        'app_helpers.rb.erb' => 'app_helpers.rb'
      },
      :javascripts => {
        'app.js.erb' => 'app.js'
      },
      :models => {},
      :stylesheets => {},
      :views => {
        'layout' => 'layout.erb',
        :app => {
          'index.html.erb' => 'index.html.erb'
        }
      }
    },
    
    :config => {
      :deploy => {
        'deploy_live.rb.erb' => 'live.rb',
        'deploy_staging.rb.erb' => 'staging.rb'
      },
      'deploy.rb.erb' => 'deploy.rb',
      'gems.rb.erb' => 'gems.rb',
      :initializers => {
        'app_initializer.rb.erb' => 'app.rb'
      },
      'initializers.rb.erb' => 'initializers.rb',
      'sprockets.yml.erb' => 'sprockets.yml'
    },
    
    :log => {},
    
    :public => {
      :images => {},
      :javascripts => {},
      :stylesheets => {
        'reset.css.erb' => 'reset.css'
      }
    },
    
    :vendor => {
      :javascripts => {}
    }
  }

end
module SinatraHelpers; end

module SinatraHelpers::Generator

  TEMPLATE = {
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
    'app.rb.erb' => 'app.rb',
    'Capfile.erb' => 'Capfile',
    'Rakefile.erb' => 'Rakefile'
  }

end
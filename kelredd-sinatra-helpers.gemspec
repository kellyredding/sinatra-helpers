# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kelredd-sinatra-helpers}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kelly Redding"]
  s.date = %q{2009-10-13}
  s.email = %q{kelly@kelredd.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "lib/sinatra_helpers", "lib/sinatra_helpers/environment_tests.rb", "lib/sinatra_helpers/erb", "lib/sinatra_helpers/erb/error_pages.rb", "lib/sinatra_helpers/erb/forms.rb", "lib/sinatra_helpers/erb/helpers.rb", "lib/sinatra_helpers/erb/links.rb", "lib/sinatra_helpers/erb/partials.rb", "lib/sinatra_helpers/erb/tags.rb", "lib/sinatra_helpers/erb.rb", "lib/sinatra_helpers/mailer", "lib/sinatra_helpers/mailer/base.rb", "lib/sinatra_helpers/mailer/exceptions.rb", "lib/sinatra_helpers/mailer/tls.rb", "lib/sinatra_helpers/mailer.rb", "lib/sinatra_helpers/version.rb", "lib/sinatra_helpers.rb"]
  s.homepage = %q{http://github.com/kelredd/sinatra-helpers}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{a ruby gem with a bunch of helpers to make Sinatra more useful}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<kelredd-useful>, [">= 0.1.25"])
      s.add_runtime_dependency(%q<tmail>, [">= 1.2.3.0"])
    else
      s.add_dependency(%q<kelredd-useful>, [">= 0.1.25"])
      s.add_dependency(%q<tmail>, [">= 1.2.3.0"])
    end
  else
    s.add_dependency(%q<kelredd-useful>, [">= 0.1.25"])
    s.add_dependency(%q<tmail>, [">= 1.2.3.0"])
  end
end

# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ventilation}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Blake Taylor"]
  s.date = %q{2010-12-03}
  s.description = %q{Helper methods for building esi tags, simplifies development bypassing the need for varnish.}
  s.email = %q{btaylor@agoragames.com}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".bundle/config",
     ".gitignore",
     "CHANGELOG.md",
     "Gemfile",
     "Gemfile.lock",
     "MIT-LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "init.rb",
     "install.rb",
     "lib/app/helpers/esi_helper.rb",
     "lib/tasks/ventilation.rake",
     "lib/ventilation.rb",
     "lib/ventilation/deep_stack.rb",
     "test/test_helper.rb",
     "test/ventilation_test.rb",
     "uninstall.rb",
     "ventilation.gemspec"
  ]
  s.homepage = %q{http://github.com/agoragames/ventilation}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Fancy ESI integration for your high prefomance web apps.}
  s.test_files = [
    "test/test_helper.rb",
     "test/ventilation_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
  end
end


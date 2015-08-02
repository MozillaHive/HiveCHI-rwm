# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jquery_mobile_rails"
  s.version = "1.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tiago Scolari", "Dylan Markow"]
  s.date = "2014-11-03"
  s.description = "JQuery Mobile files for Rails' assets pipeline"
  s.email = ["tscolari@gmail.com", "dylan@dylanmarkow.com"]
  s.homepage = "https://github.com/tscolari/jquery-mobile-rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "JQuery Mobile files for Rails."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<railties>, [">= 3.1.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end

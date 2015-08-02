# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails-html-sanitizer"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rafael Mendon\u{e7}a Fran\u{e7}a", "Kasper Timm Hansen"]
  s.date = "2015-03-10"
  s.description = "HTML sanitization for Rails applications"
  s.email = ["rafaelmfranca@gmail.com", "kaspth@gmail.com"]
  s.homepage = "https://github.com/rafaelfranca/rails-html-sanitizer"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "This gem is responsible to sanitize HTML fragments in Rails applications."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<loofah>, ["~> 2.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rails-dom-testing>, [">= 0"])
    else
      s.add_dependency(%q<loofah>, ["~> 2.0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rails-dom-testing>, [">= 0"])
    end
  else
    s.add_dependency(%q<loofah>, ["~> 2.0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rails-dom-testing>, [">= 0"])
  end
end

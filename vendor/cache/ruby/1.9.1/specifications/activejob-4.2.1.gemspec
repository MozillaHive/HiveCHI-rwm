# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "activejob"
  s.version = "4.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.date = "2015-03-19"
  s.description = "Declare job classes that can be run by a variety of queueing backends."
  s.email = "david@loudthinking.com"
  s.homepage = "http://www.rubyonrails.org"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "1.8.23"
  s.summary = "Job framework with pluggable queues."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["= 4.2.1"])
      s.add_runtime_dependency(%q<globalid>, [">= 0.3.0"])
    else
      s.add_dependency(%q<activesupport>, ["= 4.2.1"])
      s.add_dependency(%q<globalid>, [">= 0.3.0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["= 4.2.1"])
    s.add_dependency(%q<globalid>, [">= 0.3.0"])
  end
end

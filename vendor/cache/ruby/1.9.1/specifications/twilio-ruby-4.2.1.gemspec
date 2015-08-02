# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "twilio-ruby"
  s.version = "4.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Benton"]
  s.date = "2015-06-19"
  s.description = "A simple library for communicating with the Twilio REST API, building TwiML, and generating Twilio Client Capability Tokens"
  s.email = ["andrew@twilio.com"]
  s.extra_rdoc_files = ["README.md", "LICENSE.md"]
  s.files = ["README.md", "LICENSE.md"]
  s.homepage = "http://github.com/twilio/twilio-ruby"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "twilio-ruby", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "1.8.23"
  s.summary = "A simple library for communicating with the Twilio REST API, building TwiML, and generating Twilio Client Capability Tokens"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<jwt>, ["~> 1.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
    else
      s.add_dependency(%q<multi_json>, [">= 1.3.0"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<jwt>, ["~> 1.0"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<multi_json>, [">= 1.3.0"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<jwt>, ["~> 1.0"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
  end
end

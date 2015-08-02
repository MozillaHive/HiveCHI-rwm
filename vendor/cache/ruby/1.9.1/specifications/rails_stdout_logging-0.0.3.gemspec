# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_stdout_logging"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Dollar", "Jonathan Dance", "Richard Schneeman"]
  s.date = "2013-10-08"
  s.description = "Sets Rails to log to stdout"
  s.email = ["david@heroku.com", "jd@heroku.com", "richard@heroku.com"]
  s.homepage = "https://github.com/heroku/rails_stdout_logging"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Overrides Rails' built in logger to send all logs to stdout"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

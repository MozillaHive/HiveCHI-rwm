require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

null_stream = IO.new IO.sysopen('/dev/null', 'w+')
Capybara.register_driver :poltergeist do |app|
   capybara_options = { phantomjs_logger: null_stream, js_errors: false }
   Capybara::Poltergeist::Driver.new(app, capybara_options)
end

Capybara.javascript_driver = :poltergeist

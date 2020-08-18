# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendgrid/version'

Gem::Specification.new do |spec|
  spec.name        = 'sendgrid-ruby'
  spec.version     = SendGrid::VERSION
  spec.authors     = ['Elmer Thomas', 'Robin Johnson', 'Eddie Zaneski']
  spec.email       = 'help@twilio.com'
  spec.summary     = 'Official Twilio SendGrid Gem'
  spec.description = 'Official Twilio SendGrid Gem to Interact with Twilio SendGrids API in native Ruby'
  spec.homepage    = 'http://github.com/sendgrid/sendgrid-ruby'

  spec.required_ruby_version = '>= 2.2'

  spec.license     = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']
  spec.add_dependency 'ruby_http_client', '~> 3.4'
  spec.add_development_dependency 'sinatra', '>= 1.4.7', '< 3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'minitest', '~> 5.9'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'simplecov', '~> 0.18.5'
end

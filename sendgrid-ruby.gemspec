# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendgrid/version'

Gem::Specification.new do |spec|
  spec.name        = 'sendgrid-ruby'
  spec.version     = SendGrid::VERSION
  spec.authors     = ['Robin Johnson', 'Eddie Zaneski']
  spec.email       = 'community@sendgrid.com'
  spec.summary     = 'Official SendGrid Gem'
  spec.description = 'Interact with SendGrids API in Native Ruby'
  spec.homepage    = 'http://github.com/sendgrid/sendgrid-ruby'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'smtpapi'
  spec.add_dependency 'rest-client'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'bundler', '~> 1.6'
end

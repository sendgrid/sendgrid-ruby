# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sendgrid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'sendgrid-ruby'
  gem.version = SendGrid::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "Official SendGrid Gem"
  gem.description = "Interact with SendGrid's API in Native Ruby"

  gem.authors  = ['Robin J', 'Eddie Z']
  gem.email    = 'rbin@sendgrid.com'
  gem.homepage = 'http://github.com/sendgrid/sendgrid-ruby'

  gem.add_development_dependency "faraday"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-nc"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"

  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")

end
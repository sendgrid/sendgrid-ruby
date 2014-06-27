# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendgrid/version'

Gem::Specification.new do |gem|
  gem.name    = 'sendgrid-ruby'
  gem.version = SendGrid::VERSION

  gem.summary = "Official SendGrid Gem"
  gem.description = "Interact with SendGrid's API in Native Ruby"

  gem.authors  = ['Robin J', 'Eddie Z']
  gem.email    = 'rbin@sendgrid.com'
  gem.homepage = 'http://github.com/sendgrid/sendgrid-ruby'

  gem.add_dependency "smtpapi"
  gem.add_dependency "faraday"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-nc"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "bundler", "~> 1.6"

  # gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

require 'rake/testtask'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/sendgrid/test*.rb', 'test/sendgrid/helpers/mail/test*.rb', 'test/sendgrid/helpers/permissions/test*.rb']
  t.verbose = true
end

RSpec::Core::RakeTask.new(:spec)

desc "Run tests"
task default: [:spec, :test]


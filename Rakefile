require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/sendgrid/test*.rb', 'test/sendgrid/helpers/mail/test*.rb']
  t.verbose = true
end

desc "Run tests"
task :default => :test

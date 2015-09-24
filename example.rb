# test using: ruby example.rb
# using ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-darwin14]
# attachment is sent but only a corrupted 1k file

require_relative "lib/sendgrid_ruby.rb"

require 'dotenv'
Dotenv.load

# sendgrid_username = ENV['SENDGRID_USERNAME']
# sendgrid_password = ENV['SENDGRID_PASSWORD']
sendgrid_apikey = ENV['SENDGRID_APIKEY']

# client = SendGrid::Client.new(api_user: sendgrid_username, api_key: sendgrid_password)

client = SendGrid::Client.new do |c|
  # c.api_user = sendgrid_username
  c.api_key = sendgrid_apikey
end

mail = SendGrid::Mail.new do |m|
  m.to = 'elmer.thomas@sendgrid.com'
  m.from = 'elmer@thinkingserious.com'
  m.subject = 'Hello world!'
  m.text = 'I heard you like pineapple.'
end
mail.add_attachment('/tmp/report.pdf', 'july_report.pdf')
result = client.send(mail)
puts result.code
puts result.body

# puts client.send(SendGrid::Mail.new(to: 'elmer.thomas@sendgrid.com', from: 'elmer@thinkingserious.com', subject: 'Hello world!', text: 'Hi there, testing from Ruby!', html: '<b>Hi there, testing from Ruby!</b>'))

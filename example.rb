# test using: ruby example.rb
# using ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-darwin14]
# attachment is sent but only a corrupted 1k file


require_relative "lib/sendgrid-ruby.rb"

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
  m.to = 'to@example.com'
  m.to_name = 'John Doe'
  m.from = 'from@example.com'
  m.from_name = 'Jane Doe'
  m.cc = 'cc@example.com'
  m.cc_name = 'John Doe CC'
  m.bcc = 'bcc@examlpe.com'
  m.bcc_name = 'Jane Doe BCC'
  m.subject = 'Hello world!'
  m.text = 'I heard you like the beach.'
  m.html = 'I heard you like the beach <div><img src="cid:beach"></div>'
end
mail.add_content('/tmp/beach.jpg', 'beach')
mail.add_attachment('/tmp/report.pdf', 'report.pdf')
result = client.send(mail)
puts result.code
puts result.body

# puts client.send(SendGrid::Mail.new(to: 'elmer.thomas@sendgrid.com', from: 'elmer@thinkingserious.com', subject: 'Hello world!', text: 'Hi there, testing from Ruby!', html: '<b>Hi there, testing from Ruby!</b>'))

# frozen_string_literal: true
#require '/Users/manisingh/github/sendgrid/sendgrid-ruby'
require_relative '/Users/manisingh/github/sendgrid/sendgrid-ruby/lib/sendgrid-ruby.rb'
include SendGrid

# Example 1
# Sending using "global" data residency

from = SendGrid::Email.new(email: 'manisingh@twilio.com')
to = SendGrid::Email.new(email: 'manisingh@twilio.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
sg.data_residency("global")
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

# Example 2
# Sending using "eu" data residency

from = SendGrid::Email.new(email: 'sburman@twilio.com')
to = SendGrid::Email.new(email: 'sburman@twilio.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY_EU'])
sg.data_residency('eu')
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

# Example 3
# Sending using no data residency

from = SendGrid::Email.new(email: 'manisingh@twilio.com')
to = SendGrid::Email.new(email: 'manisingh@twilio.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

# Example 4
# Sending using "global" data residency in constructor

from = SendGrid::Email.new(email: 'manisingh@twilio.com')
to = SendGrid::Email.new(email: 'manisingh@twilio.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'global')
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

# Example 5
# Sending using "eu" data residency in constructor

from = SendGrid::Email.new(email: 'sburman@twilio.com')
to = SendGrid::Email.new(email: 'sburman@twilio.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY_EU'],region: 'eu')
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers



# Example 6
# Sending using "nil" data residency
# This will throw exception because data residency cannot be null

from = SendGrid::Email.new(email: 'manisingh@twilio.com')
to = SendGrid::Email.new(email: 'manisingh@twilio.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
sg.data_residency(nil)
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
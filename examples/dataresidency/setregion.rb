require 'sendgrid-ruby'

# Example 1
# Sending using "global" data residency

from = SendGrid::Email.new(email: 'example@abc.com')
to = SendGrid::Email.new(email: 'example@abc.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
sg.sendgrid_data_residency(region: "global")
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

# Example 2
# Sending using "eu" data residency

from = SendGrid::Email.new(email: 'example@abc.com')
to = SendGrid::Email.new(email: 'example@abc.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY_EU'])
sg.sendgrid_data_residency(region: 'eu')
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

# Example 3
# Sending using no data residency

from = SendGrid::Email.new(email: 'example@abc.com')
to = SendGrid::Email.new(email: 'example@abc.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
puts sg.host
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

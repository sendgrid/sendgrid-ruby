# Personalizations

This example demonstrates how to send multiple emails with personalizations. For further documentation, refer to [the SendGrid docs](https://docs.sendgrid.com/for-developers/sending-email/personalizations).

```ruby
require 'sendgrid-ruby'
include SendGrid

# Note that the domain for all From addresses must match
mail = Mail.new
mail.from = Email.new(email: 'test@example.com')
mail.add_content(Content.new(type: 'text/plain', value: 'Some test text'))
mail.subject = 'Personalized Test Email'

personalization = Personalization.new
personalization.add_to(Email.new(email: 'test1@example.com'))
mail.add_personalization(personalization)

personalization2 = Personalization.new
personalization2.add_to(Email.new(email: 'test2@example.com'))
personalization2.add_from(Email.new(email: 'test3@example.com'))
mail.add_personalization(personalization2)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
begin
    response = sg.client.mail._("send").post(request_body: mail.to_json)
rescue Exception => e
    puts e.message
end

puts response.status_code
puts response.body
puts response.headers
```
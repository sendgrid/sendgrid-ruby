# Transactional Templates

For this example, we assume you have created a [transactional template](https://sendgrid.com/docs/User_Guide/Transactional_Templates/index.html) in the UI or via the API. Following is the template content we used for testing.

Template ID (replace with your own):
```text
d-2c214ac919e84170b21855cc129b4a5f
```

Email Subject:
```text
{{subject}}
```

Template Body:
```html
<html>
  <head>
    <title></title>
  </head>
  <body>
    Hello {{name}},
    <br/><br/>
    I'm glad you are trying out the template feature!
    <br/><br/>
    I hope you are having a great day in {{city}} :)
    <br/><br/>
  </body>
</html>
```

## With Mail Helper Class
```ruby
require 'sendgrid-ruby'
include SendGrid

mail = Mail.new
mail.from = Email.new(email: 'test@example.com')
personalization = Personalization.new
personalization.add_to(Email.new(email: 'test@example.com'))
personalization.add_dynamic_template_data({
    "subject" => "Testing Templates",
    "name" => "Example User",
    "city" => "Denver"
  })
mail.add_personalization(personalization)
mail.template_id = 'd-2c214ac919e84170b21855cc129b4a5f'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
begin
    response = sg.client.mail._("send").post(request_body: mail.to_json)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
```

## Without Mail Helper Class

```ruby
require 'sendgrid-ruby'
include SendGrid

data = JSON.parse('{
  "personalizations": [
    {
      "to": [
        {
          "email": "test@example.com"
        }
      ],
      "dynamic_template_data": {
        "subject": "Testing Templates",
        "name": "Example User",
        "city": "Denver"
      }
    }
  ],
  "from": {
    "email": "test@example.com"
  },
  "template_id": "d-2c214ac919e84170b21855cc129b4a5f"
}')
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
begin
    response = sg.client.mail._("send").post(request_body: data)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
```

## Adding Attachments

```ruby
attachment = Attachment.new
attachment.content = Base64.strict_encode64(File.open(fpath, 'rb').read)
attachment.type = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
attachment.filename = fname
attachment.disposition = 'attachment'
attachment.content_id = 'Reports Sheet'
mail.add_attachment(attachment)
```

Attachments must be base64 encoded, using Base64's strict_encode64 where no line feeds are added.

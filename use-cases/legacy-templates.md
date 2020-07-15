# Legacy Templates

For this example, we assume you have created a [legacy template](https://sendgrid.com/docs/User_Guide/Transactional_Templates/index.html). Following is the template content we used for testing.

Template ID (replace with your own):
```text
13b8f94f-bcae-4ec6-b752-70d6cb59f932
```

Email Subject:
```text
<%subject%>
```

Template Body:
```html
<html>
<head>
	<title></title>
</head>
<body>
Hello -name-,
<br /><br/>
I'm glad you are trying out the template feature!
<br /><br/>
<%body%>
<br /><br/>
I hope you are having a great day in -city- :)
<br /><br/>
</body>
</html>
```

## With Mail Helper Class

```ruby
require 'sendgrid-ruby'
include SendGrid

mail = SendGrid::Mail.new
mail.from = Email.new(email: 'test@example.com')
mail.subject = 'I\'m replacing the subject tag'
personalization = Personalization.new
personalization.add_to(Email.new(email: 'test@example.com'))
personalization.add_substitution(Substitution.new(key: '-name-', value: 'Example User'))
personalization.add_substitution(Substitution.new(key: '-city-', value: 'Denver'))
mail.add_personalization(personalization)
mail.template_id = '13b8f94f-bcae-4ec6-b752-70d6cb59f932'

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
      "substitutions": {
        "-name-": "Example User",
        "-city-": "Denver"
      },
      "subject": "I\'m replacing the subject tag"
    }
  ],
  "from": {
    "email": "test@example.com"
  },
  "template_id": "13b8f94f-bcae-4ec6-b752-70d6cb59f932"
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

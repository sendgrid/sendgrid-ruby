Hello!

It is now time to implement the final piece of our v2 to v3 migration. Before we dig into writing the code, we would love to get feedback on the following proposed interfaces.

We are starting with the use cases below for the first iteration. (we have completed this work on [our C# library](https://github.com/sendgrid/sendgrid-csharp/blob/HEAD/USE_CASES.md), you can check that out for a sneak peek of where we are heading).

# Send a Single Email to a Single Recipient

The following code assumes you are storing the API key in an [environment variable (recommended)](TROUBLESHOOTING.md#environment-variables-and-your-sendgrid-api-key). If you don't have your key stored in an environment variable, you can assign it directly to `api_key` for testing purposes.

```ruby
require 'sendgrid-ruby'

from = SendGrid::Email.new('test@example.com', 'Example User')
to = SendGrid::Email.new('test@example.com', 'Example User')
subject = 'Sending with Twilio SendGrid is Fun'
plain_text_content = 'and easy to do anywhere, even with Ruby'
html_content = '<strong>and easy to do anywhere, even with Ruby</strong>'
msg = SendGrid::Mail.create(from: from,
                            tos: to,
                            subject: subject,
                            plain_text_content: plain_text_content,
                            html_content: html_content,
                            substitutions: {})

client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

begin
    response = client.send_email(msg)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.headers
```

# Send a Single Email to Multiple Recipients

The following code assumes you are storing the API key in an [environment variable (recommended)](TROUBLESHOOTING.md#environment-variables-and-your-sendgrid-api-key). If you don't have your key stored in an environment variable, you can assign it directly to `api_key` for testing purposes.

```ruby
require 'sendgrid-ruby'

from = SendGrid::Email.new('test@example.com', 'Example User')
tos = [
    SendGrid::Email.new('test1@example.com', 'Example User1'),
    SendGrid::Email.new('test2@example.com', 'Example User2'),
    SendGrid::Email.new('test3@example.com', 'Example User3')
];
subject = 'Sending with Twilio SendGrid is Fun'
plain_text_content = 'and easy to do anywhere, even with Ruby'
html_content = '<strong>and easy to do anywhere, even with Ruby</strong>'
msg = SendGrid::Mail.create(from: from,
                            tos: tos,
                            subject: subject,
                            plain_text_content: plain_text_content,
                            html_content: html_content,
                            substitutions: {})

client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

begin
    response = client.send_email(msg)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.headers
```

# Send Multiple Emails to Multiple Recipients

The following code assumes you are storing the API key in an [environment variable (recommended)](TROUBLESHOOTING.md#environment-variables-and-your-sendgrid-api-key). If you don't have your key stored in an environment variable, you can assign it directly to `api_key` for testing purposes.

```ruby
require 'sendgrid-ruby'

from = SendGrid::Email.new('test@example.com', 'Example User')
tos = [
    SendGrid::Email.new('test1@example.com', 'Example User1'),
    SendGrid::Email.new('test2@example.com', 'Example User2'),
    SendGrid::Email.new('test3@example.com', 'Example User3')
];
subjects = [
    'Sending with Twilio SendGrid is Fun',
    'Sending with Twilio SendGrid is Super Fun',
    'Sending with Twilio SendGrid is Super Duper Fun'
];
plain_text_content = 'and easy to do anywhere, even with Ruby'
html_content = '<strong>and easy to do anywhere, even with Ruby</strong>'
values = [
    'Name 1',
    'Name 2',
    'Name 3'
]
substitutions = {
    '-name1-' => values
}
msg = SendGrid::Mail.create(from: from,
                            tos: tos,
                            subject: subjects,
                            plain_text_content: plain_text_content,
                            html_content: html_content,
                            substitutions: substitutions)

client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

begin
    response = client.send_email(msg)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.headers
```

# Kitchen Sink - an example with all settings used

The following code assumes you are storing the API key in an [environment variable (recommended)](TROUBLESHOOTING.md#environment-variables-and-your-sendgrid-api-key). If you don't have your key stored in an environment variable, you can assign it directly to `api_key` for testing purposes.

```ruby
client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

from = SendGrid::Email.new('test@example.com', 'Example User')
to = SendGrid::Email.new('test@example.com', 'Example User')
subject = 'Sending with Twilio SendGrid is Fun'
plain_text_content = 'and easy to do anywhere, even with Ruby'
html_content = '<strong>and easy to do anywhere, even with Ruby</strong>'
msg = SendGrid::Message.new(from, to, subject, plain_text_content, html_content)

# For a detailed description of each of these settings, please see the [documentation](https://sendgrid.com/docs/API_Reference/api_v3.html).

msg.add_to(SendGrid::Email.new('test1@example.com', 'Example User1'))
to_emails = [
    SendGrid::Email.new('test2@example.com', 'Example User2'),
    SendGrid::Email.new('test3@example.com', 'Example User3')
];
msg.add_tos(to_emails)

msg.add_cc(SendGrid::Email.new('test4@example.com', 'Example User4'))
cc_emails = [
    SendGrid::Email.new('test5@example.com', 'Example User5'),
    SendGrid::Email.new('test6@example.com', 'Example User6')
];
msg.add_ccs(cc_emails)

msg.add_bcc(SendGrid::Email.new('test7@example.com', 'Example User7'))
bcc_emails = [
    SendGrid::Email.new('test8@example.com', 'Example User8'),
    SendGrid::Email.new('test9@example.com', 'Example User9')
];
msg.add_bccs(bcc_emails)

msg.add_header('X-Test1', 'Test1')
msg.add_header('X-Test2', 'Test2')
headers = [
    'X-Test3' => 'Test3',
    'X-Test4' => 'Test4'
]
msg.add_headers(headers)

msg.add_substitution('%name1%', 'Example Name 1');
msg.add_substitution('%city1%', 'Denver');
substitutions = [
    '%name2%' => 'Example Name 2',
    '%city2%' => 'Orange'
]
msg.add_substitutions(substitutions)

msg.add_custom_arg('marketing1', 'false')
msg.add_custom_arg('transactional1', 'true')
custom_args = [
    'marketing2' => 'true',
    'transactional2' => 'false'
]
msg.add_custom_args(custom_args)

msg.set_send_at(1461775051)

msg.set_subject('this subject overrides the Global Subject on the default Personalization')

# If you need to add more [Personalizations](https://sendgrid.com/docs/Classroom/Send/v3_Mail_Send/personalizations.html), here is an example of adding another Personalization by passing in a personalization index.

msg.add_to(SendGrid::Email.new('test10@example.com', 'Example User10'), 1)
to_emails = [
    SendGrid::Email.new('test11@example.com', 'Example User11'),
    SendGrid::Email.new('test12@example.com', 'Example User12')
];
msg.add_tos(to_emails, 1)

msg.add_cc(SendGrid::Email.new('test13@example.com', 'Example User13'), 1)
cc_emails = [
    SendGrid::Email.new('test14@example.com', 'Example User14'),
    SendGrid::Email.new('test15@example.com', 'Example User15')
];
msg.add_ccs(cc_emails, 1)

msg.add_bcc(SendGrid::Email.new('test16@example.com', 'Example User16'), 1)
bcc_emails = [
    SendGrid::Email.new('test17@example.com', 'Example User17'),
    SendGrid::Email.new('test18@example.com', 'Example User18')
];
msg.add_bccs(bcc_emails, 1)

msg.add_header('X-Test5', 'Test5', 1)
msg.add_header('X-Test6', 'Test6', 1)
headers = [
    'X-Test7' => 'Test7',
    'X-Test8' => 'Test8'
]
msg.add_headers(headers, 1)

msg.add_substitution('%name3%', 'Example Name 3', 1);
msg.add_substitution('%city3%', 'Redwood City', 1);
substitutions = [
    '%name4%' => 'Example Name 4',
    '%city4%' => 'London'
]
msg.add_substitutions(substitutions, 1)

msg.add_custom_arg('marketing3', 'true', 1)
msg.add_custom_arg('transactional3', 'false', 1)
custom_args = [
    'marketing4' => 'false',
    'transactional4' => 'true'
]
msg.add_custom_args(custom_args, 1)

msg.set_send_at(1461775052, 1)

msg.set_subject('this subject overrides the Global Subject on the second Personalization', 1)

# The values below this comment are global to the entire message

msg.set_from(SendGrid::Email.new('test0@example.com', 'Example User0'))

msg.set_global_subject('Sending with Twilio SendGrid is Fun');

msg.add_content(MimeType::Text, 'and easy to do anywhere, even with Ruby')
msg.add_content(MimeType::Html, '<strong>and easy to do anywhere, even with Ruby</strong>')
contents = [
    SendGrid::Content.new('text/calendar', 'Party Time!!'),
    SendGrid::Content.new('text/calendar2', 'Party Time 2!!')
]
msg.add_contents(contents)

msg.add_attachment('balance_001.pdf',
                   'base64 encoded content',
                   'application/pdf',
                   'attachment',
                   'Balance Sheet')

attachments = [
    SendGrid::Attachment.new('banner.png',
                             'base64 encoded content',
                             'image/png',
                             'inline',
                             'Banner'),
    SendGrid::Attachment.new('banner2.png',
                             'base64 encoded content',
                             'image/png',
                             'inline',
                             'Banner 2'),                             
]
msg.add_attachments(attachments)

msg.set_template_id('13b8f94f-bcae-4ec6-b752-70d6cb59f932')

msg.add_global_header('X-Day', 'Monday')
global_headers = [
    'X-Month' => 'January',
    'X-Year' => '2017'
]
msg.set_global_headers(global_headers)

msg.add_section('%section1%', 'Substitution for Section 1 Tag')
sections = [
    '%section2%' => 'Substitution for Section 2 Tag',
    '%section3%' => 'Substitution for Section 3 Tag'    
]
msg.add_sections(sections)

begin
    response = client.send_email(msg)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.headers
```

# Attachments

The following code assumes you are storing the API key in an [environment variable (recommended)](TROUBLESHOOTING.md#environment-variables-and-your-sendgrid-api-key). If you don't have your key stored in an environment variable, you can assign it directly to `api_key` for testing purposes.

```ruby
client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

from = SendGrid::Email.new('test@example.com', 'Example User')
to = SendGrid::Email.new('test@example.com', 'Example User')
subject = 'Sending with Twilio SendGrid is Fun'
plain_text_content = 'and easy to do anywhere, even with Ruby'
html_content = '<strong>and easy to do anywhere, even with Ruby</strong>'
msg = SendGrid::Message.new(from, to, subject, plain_text_content, html_content)
bytes = File.read('/path/to/the/attachment.pdf')
encoded = Base64.encode64(bytes)
msg.add_attachment('balance_001.pdf',
                   encoded,
                   'application/pdf',
                   'attachment',
                   'Balance Sheet')

begin
    response = client.send_email(msg)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.headers
```

# Transactional Templates

The following code assumes you are storing the API key in an [environment variable (recommended)](TROUBLESHOOTING.md#environment-variables-and-your-sendgrid-api-key). If you don't have your key stored in an environment variable, you can assign it directly to `api_key` for testing purposes.

For this example, we assume you have created a [transactional template](https://sendgrid.com/docs/User_Guide/Transactional_Templates/index.html). Following is the template content we used for testing.

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

```ruby
client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])

from = SendGrid::Email.new('test@example.com', 'Example User')
to = SendGrid::Email.new('test@example.com', 'Example User')
subject = 'Sending with Twilio SendGrid is Fun'
plain_text_content = 'and easy to do anywhere, even with Ruby'
html_content = '<strong>and easy to do anywhere, even with Ruby</strong>'
msg = SendGrid::Message.new(from, to, subject, plain_text_content, html_content)

substitutions = [
    '-name-' => 'Example User',
    '-city-' => 'Denver'
]
msg.add_substitutions(substitutions)
msg.set_template_id('13b8f94f-bcae-4ec6-b752-70d6cb59f932')

begin
    response = client.send_email(msg)
rescue Exception => e
    puts e.message
end
puts response.status_code
puts response.body
puts response.headers
```

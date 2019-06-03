This documentation provides examples for specific use cases. Please [open an issue](https://github.com/sendgrid/sendgrid-ruby/issues) or make a pull request for any use cases you would like us to document here. Thank you!

# Table of Contents

* [Transactional Templates](#transactional-templates)
  * [With Mail Helper Class](#with-mail-helper-class)
  * [Without Mail Helper Class](#without-mail-helper-class)
* [Legacy Templates](#legacy-templates)
  * [With Mail Helper Class](#with-mail-helper-class-1)
  * [Without Mail Helper Class](#without-mail-helper-class-1)
  * [Adding Attachments](#adding-attachments)
* [How to Setup a Domain Authentication](#how-to-setup-a-domain-authentication)
* [How to View Email Statistics](#how-to-view-email-statistics)
* [Send a SMS Message](#send-a-sms-message)
  * [1. Obtain a Free Twilio Account](#1-obtain-a-free-twilio-account)
  * [2. Update Your Environment Variables](#2-update-your-environment-variables)
    * [Mac](#mac)
    * [Windows](#windows)
  * [3. Install the Twilio Helper Library](#3-install-the-twilio-helper-library)
  * [4. Setup Work](#4-setup-work)
  * [5. Send an SMS](#5-send-an-sms)

<a name="transactional-templates"></a>
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

<a name="legacy-templates"></a>
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

<a name="domain-authentication"></a>
# How to Setup a Domain Authentication

You can find documentation for how to setup a domain authentication via the UI [here](https://sendgrid.com/docs/ui/account-and-settings/how-to-set-up-domain-authentication/) and via API [here](https://github.com/sendgrid/sendgrid-nodejs/blob/master/packages/client/USAGE.md#sender-authentication).

Find more information about all of SendGrid's authentication related documentation [here](https://sendgrid.com/docs/ui/account-and-settings/).

<a name="email-statistics"></a>
# How to View Email Statistics

You can find documentation for how to view your email statistics via the UI [here](https://app.sendgrid.com/statistics) and via API [here](https://github.com/sendgrid/sendgrid-ruby/blob/master/USAGE.md#stats).

Alternatively, we can post events to a URL of your choice via our [Event Webhook](https://sendgrid.com/docs/API_Reference/Webhooks/event.html) about events that occur as Twilio SendGrid processes your email.

You can also use the email statistics helper to make it easier to interact with the API.

```ruby
require 'sendgrid-ruby'
require 'date'

include SendGrid

sg_client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
stats = SendGrid::EmailStats.new(sendgrid_client: sg_client)

# Fetch stats by day, between 2 dates
from = Date.new(2017, 10, 01)
to = Date.new(2017, 10, 12)

email_stats = stats.by_day(from, to)

email_stats.metrics

if !email_stats.error?
  email_stats.metrics.each do |metric|
    puts "Date - #{metric.date}"
    puts "Number of Requests - #{metric.requests}"
    puts "Bounces - #{metric.bounces}"
    puts "Opens - #{metric.opens}"
    puts "Clicks - #{metric.clicks}"
  end
end

# Fetch stats by week, between 2 dates for a category
from = Date.new(2017, 10, 01)
to = Date.new(2017, 10, 12)
category = 'abcd'

email_stats = stats.by_week(from, to, category)

if !email_stats.error?
  email_stats.metrics.each do |metric|
    puts "Date - #{metric.date}"
    puts "Number of Requests - #{metric.requests}"
    puts "Bounces - #{metric.bounces}"
    puts "Opens - #{metric.opens}"
    puts "Clicks - #{metric.clicks}"
  end
end

```

<a name="sms"></a>
# Send a SMS Message

Following are the steps to add Twilio SMS to your app:

## 1. Obtain a Free Twilio Account

Sign up for a free Twilio account [here](https://www.twilio.com/try-twilio?source=sendgrid-ruby).

## 2. Update Your Environment Variables

You can obtain your Account Sid and Auth Token from [twilio.com/console](https://twilio.com/console).

### Mac

```bash
echo "export TWILIO_ACCOUNT_SID='YOUR_TWILIO_ACCOUNT_SID'" > twilio.env
echo "export TWILIO_AUTH_TOKEN='YOUR_TWILIO_AUTH_TOKEN'" >> twilio.env
echo "twilio.env" >> .gitignore
source ./twilio.env
```

### Windows

Temporarily set the environment variable (accessible only during the current CLI session):

```bash
set TWILIO_ACCOUNT_SID=YOUR_TWILIO_ACCOUNT_SID
set TWILIO_AUTH_TOKEN=YOUR_TWILIO_AUTH_TOKEN
```

Permanently set the environment variable (accessible in all subsequent CLI sessions):

```bash
setx TWILIO_ACCOUNT_SID "YOUR_TWILIO_ACCOUNT_SID"
setx TWILIO_AUTH_TOKEN "YOUR_TWILIO_AUTH_TOKEN"
```

## 3. Install the Twilio Helper Library

To install using [Bundler][bundler] grab the latest stable version:

```ruby
gem 'twilio-ruby', '~> 5.23.1'
```

To manually install `twilio-ruby` via [Rubygems][rubygems] simply gem install:

```bash
gem install twilio-ruby -v 5.23.1
```

## 4. Setup Work

```ruby
require 'twilio-ruby'

# put your own credentials here
account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token
```

## 5. Send an SMS

```ruby
@client.api.account.messages.create(
  from: '+14159341234',
  to: '+16105557069',
  body: 'Hey there!'
)
```

For more information, please visit the [Twilio SMS Ruby documentation](https://www.twilio.com/docs/sms/quickstart/ruby).

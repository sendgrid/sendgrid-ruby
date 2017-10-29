<a name="slack-events"></a>
# Integrations - Slack Events

## Table of Contents

* [Credential Storage](#credentials)
* [Creating endpoint](#endpoint)
* [Slack Setup](#setup)
* [Setting Up a Webserver](#webserver)
* [Conclusion](#conclusion)

### Overview

This tutorial will go over how to setup a simple integration with Slack that allows us to send email using a slack slash command. You'll need the following to complete this tutorial.

* SendGrid API Key
* Slack OAuth Token
* Slack account & Valid Slack Workspace
* ngrok (if you do not have an publicly accessible web endpoint)
* Sinatra 
* Sendgrid ruby gem

Slack allows us to create [apps](https://api.slack.com/slack-apps). Apps can have different types of capabilities. One such capability is a [slash command](https://api.slack.com/slash-commands). Slash Commands enable Slack users to interact with your app directly from Slack. We will write a simple slash command with following structure.
```
/sendmail /to <comma separated list of email ids> /subject <subject message> /body <Plain text body>
``` 


<a name="credentials"></a>
### Credential Storage

It's not a good practice to directly insert API keys (or any authorization information) into your script for security reasons. As an alternative, please save your credentials in their respective `.env` files, with the following command:
```
echo "export SENDGRID_API_KEY='YOUR_API_KEY'" > sendgrid.env
echo "export SLACK_SENDMAIL_TOKEN='YOUR_APP_TOKEN'" > slack.env //You will receive this after creating an app.
source ./sendgrid.env && source ./slack.env
```


<a name="endpoint"></a>
### Creating endpoint
Every Slack slash commands needs a publically available endpoint at the time of creating new slash command. Since we are using a development environment, we can use [ngrok](https://ngrok.com/) to expose a locally available endpoint.

Please follow installation [instructions](https://ngrok.com/download). Once you are able to verify installation with `ngrok help`, expose a local port. We are using [Sinatra](http://www.sinatrarb.com/) as web server which uses `4567` port as default.   
Run `ngrok http 4567` and keep it running. Copy the **https** forwarding url. It should look like `https://be07f634.ngrok.io`. We will need this in the slack setup step.


<a name="setup"></a>
### Slack Setup

Once you have a functional Slack workspace running, you'll need to:

1. Go to Slack [apps](https://api.slack.com/apps), and then click on create a new app.

2. On the sidebar under Features select **Slash Commands** and click on to create new command.

3. Write the command as **`/sendmail`**

4. Paste the ngrok forwarding link. Add **`/commands`** at end of the url. This will be our end point for slash commands.

5. Put a nice short description for our command. e.g _Allows to send mail to people with given subject and content._

6. In usage hint put up the format for using our command. e.g.  ` /sendmail /to <comma separated list of email ids> /subject <subject message> /body <Plain text body> `

7. Save the command and head over to install the app into your slack workspace in the left sidebar. Installing the app will also generate an OAuth token you can store. We will not be using this token for our integration.

<a name="webserver"></a>
### Setting Up a webserver

If your do not have `sinatra` installed, use `gem install sinatra`.

Now that you have an installed Slack app let's setup a basic server that will serve our commands:
Create a `simeple-server.rb` and paste the following code.

```ruby
require 'sinatra'
class API < Sinatra::Base
  post '/commands' do
  end
end
API.run!
```
Start the server.

```ruby
ruby simple-server.rb
```

We will also add `sendgrid-ruby` to our code. If you do not have `sendgrid-ruby` installed, use `gem install sendgrid-ruby`.


```ruby
require 'sendgrid-ruby'
class API < Sinatra::Base
  include SendGrid
.
.
```

Since our webserver accepts all requests on the endpoint. It is preferred to authenticate a request before processing it.
Make sure you have exported the environment variables in the previous step.

```ruby
  post '/commands' do
    data = request.params
    return 401 if data['token'] != ENV['SLACK_SENDMAIL_TOKEN']
  end
```
Then we need to parse all the fields from the command.

```ruby
def parse_fields(data, command)
  fields = {}
  return fields if data.nil?
  case command
  when COMMAND_SENDMAIL
    regex = /^\/to\s(?<to_list>\S+)\s*\/subject(?<subject>.*)\/body(?<body>.*)$/
    fields = data.match(regex)
  end
  return fields
end
```

Now we will use `sendgrid-ruby` gem to create and send mail.

```ruby
fields = self.parse_fields(data['text'].strip, COMMAND_SENDMAIL)
to_list = fields['to_list'].split(',')
subject = fields['subject']
body = fields['body']
from = data['team_domain'].capitalize
from = Email.new(email: from + '@example.com')
content = Content.new(type: 'text/plain', value: body)
mail = Mail.new
mail.from = from
to_list.each do |to|
  personlization = Personalization.new
  to = Email.new(email: to.strip)
  personlization.add_to(to)
  mail.add_personalization(personlization)
end
mail.subject = subject
mail.add_content(content)
```
We can add validation on `to` field before adding it to personalization.

```ruby
.
to_list.each do |to|
  next if !valid_email(to)
  personlization = Personalization.new
.
.

def valid_email(email)
  regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  if email.match(regex)
    return true
  else
    return false
  end
end
```


Now we can send the mail

```ruby
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
```

Slack expects a reply from command request. We will send the response message based on the response from sendgrid mail action. If its an error, we will collect the one or more error messages and send it as a reply.

```ruby
if response.status_code == "202"
  return "Email sent :+1:"
else
  body = JSON.parse(response.body)
  return "Sorry there was some issue while sending email.\n This is the error we got: _#{body['errors'].collect{|e| e['message']}.join(" ,")}_ \nPlease try again :cry:"
end
```

The complete code is available [here](slack_integration.rb)

<a name="conclusion"></a>
### Conclusion

Now we can use `/sendmail` command to send email from slack.   
e.g.
* `/sendmail /to person1@example.com,person2@example.com /subject Slack Integration /body Hi, This message was sent from slack`.

This is a simple example of slack integration with sendgrid-ruby. You can explore all the capabilities of an app and use some ideas from this example.
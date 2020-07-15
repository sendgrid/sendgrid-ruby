First, follow the [Twilio Setup](twilio-setup.md) guide for creating a Twilio account and setting up environment variables with the proper credentials.

Then, install the Twilio Helper Library. Add this line to your application's Gemfile:

```bash
gem 'twilio-ruby'
```

And then execute:

```bash
bundle
```

Or install it yourself using:

```bash
gem install twilio-ruby
```

Finally, send a message.

```ruby
require 'twilio-ruby'

# put your own credentials here
account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token
@client.api.account.messages.create(
  from: '+14159341234',
  to: '+16105557069',
  body: 'Hey there!'
)
```

For more information, please visit the [Twilio SMS Ruby documentation](https://www.twilio.com/docs/sms/quickstart/ruby).

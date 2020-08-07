First, follow the [Twilio Setup](twilio-setup.md) guide for creating a Twilio account and setting up environment variables with the proper credentials.

Then, initialize the Twilio Email Client.

```ruby
mail_client = TwilioEmail::API(username: ENV['TWILIO_API_KEY'], password: ENV['TWILIO_API_SECRET'])

# or

mail_client = TwilioEmail::API(username: ENV['TWILIO_ACCOUNT_SID'], password: ENV['TWILIO_AUTH_TOKEN'])
```

This client has the same interface as the `SendGrid::API` client.

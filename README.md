# SendGrid::Ruby

This Gem allows you to quickly and easily send emails through SendGrid's Web API using native Ruby.

You can read our official documentation on the Web API's Mail feature [here](https://sendgrid.com/docs/API_Reference/Web_API/mail.html).


## Installation

Add this line to your application's Gemfile:

    gem 'sendgrid-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sendgrid-ruby

## Usage

Create a new client with your SendGrid Username and Password.

```ruby
require 'sendgrid-ruby'

client = SendGrid::Client.new(api_user: 'SENDGRID_USERNAME', api_key: 'SENDGRID_PASSWORD')
```

Create a new Mail object and send:
```ruby
mail = SendGrid::Mail.new do |m|
  m.to = 'test@sendgrid.com'
  m.from = 'taco@cat.limo'
  m.subject = 'Hello world!'
  m.text = 'I heard you like pineapple.'
end

puts client.send(mail) 
# {"message":"success"}
```

You can also create a mail object with a hash.
```ruby
client.send(SendGrid::Mail.new(to: 'example@example.com', from: 'taco@cat.limo', subject: 'Hello world!', text: 'Hi there!', html: '<b>Hi there!</b>'))
	
	# {"message":"success"}
```

#### Available Params

```ruby
params = {
	:to,
	:to_name,
	:from,
	:from_name,
	:subject,
	:text,
	:html,
	:cc,
	:bcc,
	:reply_to,
	:date,
	:smtpapi,
	:attachments
}
```

#### Using the X-SMTPAPI Header

To utilize the X-SMTPAPI header, we have directly integrated the [smtpapi-ruby](https://github.com/SendGridJP/smtpapi-ruby) gem.  To initialize, you have two options:

Create your own and pass it in to the initialize method:
```ruby
header = Smtpapi::Header.new
# Do things to the header
header.add_substitution('keep', ['secret'])
mail = SendGrid::Mail.new(smtpapi: header)
```
Or use the one that we create and expose:
```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_substitution('keep', ['secret'])
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

***Hit up [@rbin](http://twitter.com/rbin) or [@eddiezane](http://twitter.com/eddiezane) on Twitter with any issues.***

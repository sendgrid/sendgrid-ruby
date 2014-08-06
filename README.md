# SendGrid::Ruby

This Gem allows you to quickly and easily send emails through SendGrid using Ruby.


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

client = SendGrid::Client.new('SENDGRID_USERNAME', 'SENDGRID_PASSWORD')
```

Create a new mail object and send it off!
```ruby
mail = SendGrid::Mail.new do |m|
  m.to = 'eddiezane@sendgrid.com'
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

#### Available params

```ruby
params = {
  :to
  :from        => mail.from,
  :subject     => mail.subject,
  :text        => (mail.text if mail.text),
  :html        => (mail.html if mail.html),
  :fromname    => (mail.from_name if mail.from_name),
  :toname      => (mail.to_name if mail.to_name),
  :date        => (mail.date if mail.date),
  :replyto     => (mail.reply_to if mail.reply_to),
  :bcc         => (mail.bcc if mail.bcc),
  :'x-smtpapi' => (mail.smtpapi.to_json if mail.smtpapi),
  :files       => ({} unless mail.attachments.empty?)
}
```

#### Using the X-SMTPAPI Header

To utilise the X-SMTPAPI header, we have directly integrated the <a href="https://github.com/SendGridJP/smtpapi-ruby">stmpapi-ruby</a> gem.  To initialise, use:

```ruby
header = Smtpapi::Header.new
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

***Hit up <a href="http://twitter.com/rbin">@rbin</a> or <a href="http://twitter.com/eddiezane">@eddiezane</a> on Twitter with any issues.***

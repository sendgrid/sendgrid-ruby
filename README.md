# SendGrid::Ruby

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'sendgrid-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sendgrid-ruby

## Usage

Create a new client with your SendGrid username and password.

```ruby
require 'sendgrid-ruby'

client = SendGrid::Client.new('SENDGRID_USERNAME', 'SENDGRID_PASSWORD')
```

Create a new mail object and send it off!
```ruby
mail = SendGrid::Mail.new

mail.to = 'eddiezane@sendgrid.com'
mail.from = 'taco@cat.limo'
mail.subject = 'Hello world!'
mail.text = 'I heard you like pineapple.'

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



## Contributors:

Using RSpec for Testing, and Guard for test automation.

Clone repo, Install any deps, then run:

    guard

From the base directory to watch for file changes / automate tests. 

Uses github.com/SendGridJP/smtpapi-ruby for smtpapi lib.

Also using Faraday to construct the email and post.   

    ##
      ##  THIS IS HOW I WANNA USE IT.
        #  sg = sendgrid::Client.new("Myuser", "Mykey")
        #  m = sendgrid::Mail.new()
        #  m.to("robin@sendgrid.com")
        #  sg.send(m)

        ##   AND - I want both options!

        #  m = sendgrid::Mail.new(:to => "me@rbin.co", :from => "email@mcgee.me")
        #  sg.send(m)
        #
      ##
    ##  


## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

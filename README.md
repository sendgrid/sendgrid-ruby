# SendGrid::Ruby

This Gem allows you to quickly and easily send emails through SendGrid's Web API using native Ruby.

You can read our official documentation on the Web API's Mail feature [here](https://sendgrid.com/docs/API_Reference/Web_API/mail.html).


## Installation

Add this line to your application's Gemfile:

    gem 'sendgrid-ruby'

And then execute:

    $ bundle

Or install it yourself using:

    $ gem install sendgrid-ruby

## Usage

Create a new client with your SendGrid Username and Password.

```ruby
require 'sendgrid-ruby'

# As a hash
client = SendGrid::Client.new(api_user: 'SENDGRID_USERNAME', api_key: 'SENDGRID_PASSWORD')

# Or as a block
client = SendGrid::Client.new do |c|
  c.api_user = 'SENDGRID_USERNAME'
  c.api_key = 'SENDGRID_PASSWORD'
end
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

You can also create a Mail object with a hash:
```ruby
client.send(SendGrid::Mail.new(to: 'example@example.com', from: 'taco@cat.limo', subject: 'Hello world!', text: 'Hi there!', html: '<b>Hi there!</b>'))
	
# {"message":"success"}
```

#### Attachments

Attachments can be added to a Mail object with the `add_attachment` method. The first parameter is the path to the file, the second (optional) parameter is the desired name of the file. If a file name is not provided, it will use the original filename.
```ruby
mail.add_attachment('/tmp/report.pdf', 'july_report.pdf')
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


#### Setting Params

Params can be set in the usual Ruby ways, including a block or a hash.

````ruby
mail = SendGrid::Mail.new do |m|
  m.to = 'rbin@sendgrid.com'
  m.from = 'taco@rbin.codes'
end

client.send(SendGrid::Mail.new(to: 'rbin@sendgrid.com', from: 'taco@cat.limo'))
````

#### :to

Using the **:to** param, we can pass a single email address as a string, or an array of email address strings.

````ruby
mail = SendGrid::Mail.new
mail.to = 'taco@rbin.codes'
# or
mail.to = ['Example Dude <example@email.com>', 'john@email.com']
# or
mail.to = ['rbin@sendgrid.com', 'taco@cat.limo']
````

#### :from

```ruby
mail = SendGrid::Mail.new
mail.from = 'me@sendgrid.com'
```

#### :cc

As with **:to**, **:cc** can take a single string or an array of strings.

```ruby
mail = SendGrid::Mail.new
mail.cc = ['robin@sendgrid.com', 'taco@cat.limo']
```

#### :bcc

As with **:to** and **:cc**, **:bcc** can take a single string or an array of strings.

```ruby
mail = SendGrid::Mail.new
mail.bcc = ['robin@sendgrid.com', 'taco@cat.limo']
```

#### :subject

```ruby
mail = SendGrid::Mail.new
mail.subject = 'This is a subject string'
```

### Email Bodies:
#### :text

Using the **:text** param allows us to add plain text to our email body.

```ruby
mail = SendGrid::Mail.new
mail.text = 'WHATTUP KITTY CAT!?'
```

#### :html

Using the **:html** param allows us to add html content to our email body.
```ruby
mail = SendGrid::Mail.new
mail.html = '<html><body>Stuff in here, yo!</body></html>'
```


## Using SendGrid's X-SMTPAPI Header


<blockquote>
To utilize the X-SMTPAPI header, we have directly integrated the <a href="https://github.com/SendGridJP/smtpapi-ruby">SendGridJP/smtpapi-ruby</a> gem.
</blockquote>



## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

***Hit up [@rbin](http://twitter.com/rbin) or [@eddiezane](http://twitter.com/eddiezane) on Twitter with any issues.***

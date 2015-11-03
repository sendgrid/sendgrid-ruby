# SendGrid::Ruby

This Gem allows you to quickly and easily send emails through SendGrid's Web API using native Ruby.

You can read our official documentation on the Web API's Mail feature [here](https://sendgrid.com/docs/API_Reference/Web_API/mail.html).

[![BuildStatus](https://travis-ci.org/sendgrid/sendgrid-ruby.svg?branch=master)](https://travis-ci.org/sendgrid/sendgrid-ruby)


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

# or as a block with the API key only #
client = SendGrid::Client.new do |c|
  c.api_key = 'SENDGRID_APIKEY'
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

res = client.send(mail)
puts res.code
puts res.body
# 200
# {"message"=>"success"}
```

You can also create a Mail object with a hash:
```ruby
res = client.send(SendGrid::Mail.new(to: 'example@example.com', from: 'taco@cat.limo', subject: 'Hello world!', text: 'Hi there!', html: '<b>Hi there!</b>'))
puts res.code
puts res.body
# 200
# {"message"=>"success"}
```

#### Attachments

Attachments can be added to a Mail object with the `add_attachment` method. The first parameter is the path to the file, the second (optional) parameter is the desired name of the file. If a file name is not provided, it will use the original filename.
```ruby
mail.add_attachment('/tmp/report.pdf', 'july_report.pdf')
```

#### Inline Content

Inline content can be added to a Mail object with the `add_content` method. The first parameter is the path to the file, the second parameter is the cid to be referenced in the html. 
```ruby
mail = SendGrid::Mail.new do |m|
  m.to = 'test@sendgrid.com'
  m.from = 'taco@cat.limo'
  m.subject = 'Hello world!'
  m.text = 'I heard you like the beach.'
  m.html = 'I heard you like the beach <div><img src="cid:beach"></div>'
end
mail.add_content('/tmp/beach.jpg', 'beach')
result = client.send(mail)
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
	:cc_name,
	:bcc,
	:bcc_name,
	:reply_to,
	:date,
	:smtpapi,
	:attachments,
	:template
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

#### :template

The **:template** param allows us to specify a template object for this email to use. The initialized `Template` will automatically be included in the `smtpapi` header and passed to SendGrid.

```ruby
template = SendGrid::Template.new('MY_TEMPLATE_ID')
mail.template = template
```

## Working with Templates

Another easy way to use the [SendGrid Templating](https://sendgrid.com/docs/API_Reference/Web_API_v3/Template_Engine/index.html) system is with the `Recipient`, `Mail`, `Template`, and `TemplateMailer` objects.

Create some `Recipients`

```ruby
users = User.where(email: ['first@gmail.com', 'second@gmail.com'])

recipients = []

users.each do |user|
  recipient = SendGrid::Recipient.new(user.email)
  recipient.add_substitution('first_name', user.first_name)
  recipient.add_substitution('city', user.city)

  recipients << recipient
end
```

Create a `Template`

```ruby
template = SendGrid::Template.new('MY_TEMPLATE_ID')
```

Create a `Client`

```ruby
client = SendGrid::Client.new(api_user: my_user, api_key: my_key)
```

Initialize mail defaults and create the `TemplateMailer`

```ruby
mail_defaults = {
  from: 'admin@email.com',
  html: '<h1>I like email</h1>',
  text: 'I like email',
  subject: 'Email is great',
}

mailer = SendGrid::TemplateMailer.new(client, template, recipients)
```

Mail it!

```ruby
mailer.mail(mail_defaults)
```

## Using SendGrid's X-SMTPAPI Header

<blockquote>
To utilize the X-SMTPAPI header, we have directly integrated the <a href="https://github.com/SendGridJP/smtpapi-ruby">SendGridJP/smtpapi-ruby</a> gem.
For more information, view our <a href=https://sendgrid.com/docs/API_Reference/SMTP_API/index.html>SMTPAPI docs page</a>.
</blockquote>

```ruby

header = Smtpapi::Header.new
header.add_to(['john.doe@example.com', 'jane.doe@example.com'])
header.add_substitution('keep', ['secret'])        # sub = {keep: ['secret']}
header.add_substitution('other', ['one', 'two'])   # sub = {keep: ['secret'], other: ['one', 'two']}
header.add_unique_arg("unique_code", "8675309")
header.add_category("Newsletter")
header.add_filter('templates', 'enable', 1)	   # necessary for each time the template engine is used
header.add_filter('templates', 'template_id', '1234-5678-9100-abcd')
header.set_ip_pool("marketing_ip_pool")
mail.smtpapi = header

```
## Testing ##

`bundle exec rake test`

## Deploying ##

1. Confirm tests pass `bundle exec rake test`
2. Bump the version in `lib/sendgrid/version.rb` and `spec/lib/sendgrid_spec.rb`
3. Update CHANGELOG.md
4. Commit Version bump vX.X.X
5. `rake release`
6. Push changes to GitHub
7. Release tag on GitHub vX.X.X

## Contributing ##

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

***Hit up [@rbin](http://twitter.com/rbin) or [@sendgrid](http://twitter.com/sendgrid) on Twitter with any issues.***


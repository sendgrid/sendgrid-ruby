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

To utilize the X-SMTPAPI header, we have directly integrated the [smtpapi-ruby](https://github.com/SendGridJP/smtpapi-ruby) gem.

#### add_to

You can directly generate an x-smtpapi add_to header instead of using to *:to* param.  ***Please note, this will override all params.***

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_to('me@rbin.codes')
mail.smtpapi.add_to('eddiez@otheremail.com')
```

#### set_tos

```ruby
mail.smtpapi.set_tos(['rbin@cat.codes', 'eddie@taco.bell'])
```

#### add_substitution

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_substitution('keep', array('secret'))        # sub = {keep: ['secret']}
mail.smtpapi.add_substitution('other', array('one', 'two'))   # sub = {keep: ['secret'], other: ['one', 'two']}
```

#### set_substitutions

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.set_substitutions({'keep' => 'secret'})  # sub = {keep: ['secret']}
```

#### add_unique_arg

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_unique_arg('cat', 'dogs')
```

#### set_unique_args

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.set_unique_args({'cow' => 'chicken'})
mail.smtpapi.set_unique_args({'dad' => 'proud'})
```

#### add_category

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_category('tactics') # category = ['tactics']
mail.smtpapi.add_category('advanced') # category = ['tactics', 'advanced']
```

#### set_categories

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.set_categories(['tactics', 'advanced']) # category = ['tactics', 'advanced']
```

#### add_section

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_section('-charge-', 'This ship is useless.'])
mail.smtpapi.add_section('-bomber-', 'Only for sad vikings.'])
```

#### set_sections

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.set_sections({'-charge-' => 'This ship is useless.'})
```

#### add_filter

```ruby
mail = SendGrid::Mail.new
mail.smtpapi.add_filter('footer', 'enable', 1)
mail.smtpapi.add_filter('footer', 'text/html', '<strong>boo</strong>')
```

#### set_filters

```ruby
mail = SendGrid::Mail.new
filter = {
  'footer' => {
    'setting' => {
      'enable' => 1,
      "text/plain" => 'You can haz footers!'
    }
  }
}
mail.smtpapi.set_filters(filter)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

***Hit up [@rbin](http://twitter.com/rbin) or [@eddiezane](http://twitter.com/eddiezane) on Twitter with any issues.***

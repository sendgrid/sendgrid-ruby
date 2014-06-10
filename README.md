## Contributors:

Using RSpec for Testing, and Guard for test automation.

Clone repo, Install any deps, then run:

    guard

From the base directory to watch for file changes / automate tests. 

Also using Faraday to construct the email and post.   

    ##
      ##  THIS IS HOW I WANNA USE IT.
        #  sg = sendgrid::Client.new("Myuser", "Mykey")
        #  m = sendgrid::Mail.new()
        #  m.to("robin@sendgrid.com")
        #  sg.send(m)

        ##   OR

        #  m = sendgrid::Mail.new(:to => "me@rbin.co", :from => "tits@mcgee.me")
        #  sg.send(m)
        #
      ##
    ##  



# Sendgrid::Ruby

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'sendgrid-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sendgrid-ruby

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

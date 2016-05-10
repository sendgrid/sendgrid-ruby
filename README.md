[![Travis Badge](https://travis-ci.org/sendgrid/sendgrid-ruby.svg?branch=master)](https://travis-ci.org/sendgrid/sendgrid-ruby)

**This library allows you to quickly and easily use the SendGrid Web API via Ruby.**

**NOTE: The `/mail/send/beta` endpoint is currently in beta!

Since this is not a general release, we do not recommend POSTing production level traffic through this endpoint or integrating your production servers with this endpoint.

When this endpoint is ready for general release, your code will require an update in order to use the official URI.

By using this endpoint, you accept that you may encounter bugs and that the endpoint may be taken down for maintenance at any time. We cannot guarantee the continued availability of this beta endpoint. We hope that you like this new endpoint and we appreciate any [feedback](dx+mail-beta@sendgrid.com) that you can send our way.**

# Installation

Add this line to your application's Gemfile:

    gem 'sendgrid-ruby'

And then execute:

    $ bundle

Or install it yourself using:

    $ gem install sendgrid-ruby

## Dependencies

- [Ruby-HTTP-Client](https://github.com/sendgrid/ruby-http-client)

## Environment Variables

First, get your free SendGrid account [here](https://sendgrid.com/free?source=sendgrid-ruby).

Next, update your environment with your [SENDGRID_API_KEY](https://app.sendgrid.com/settings/api_keys).

```bash
echo "export SENDGRID_API_KEY='YOUR_API_KEY'" > sendgrid.env
echo "sendgrid.env" >> .gitignore
source ./sendgrid.env
```

# Quick Start

## Hello Email

```ruby
require 'sendgrid-ruby'

from = Email.new(email: 'dx@sendgrid.com')
subject = 'Hello World from the SendGrid Ruby Library'
to = Email.new(email: 'elmer.thomas@sendgrid.com')
content = Content.new(type: 'text/plain', value: 'some text here')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').beta.post(request_body: mail.to_json)
puts response.status_code
puts response.response_body
puts response.response_headers
```

## General v3 Web API Usage

```ruby
require 'sendgrid-ruby'
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.api_keys.get()
puts response.status_code
puts response.response_body
puts response.response_headers
```

# Announcements

**BREAKING CHANGE as of XXXX.XX.XX**

Version `2.0.0` is a breaking change for the entire library.

Version 2.0.0 brings you full support for all Web API v3 endpoints. We
have the following resources to get you started quickly:

-   [SendGrid
    Documentation](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html)
-   [Usage
    Documentation](https://github.com/sendgrid/sendgrid-ruby/blob/master/USAGE.md)
-   [Example
    Code](https://github.com/sendgrid/sendgrid-ruby/blob/master/examples)

Thank you for your continued support!

## Roadmap

[Milestones](https://github.com/sendgrid/sendgrid-ruby/milestones)

## How to Contribute

We encourage contribution to our libraries, please see our [CONTRIBUTING](https://github.com/sendgrid/sendgrid-ruby/blob/master/CONTRIBUTING.md) guide for details.

* [Feature Request](https://github.com/sendgrid/sendgrid-ruby/blob/master/CONTRIBUTING.md#feature_request)
* [Bug Reports](https://github.com/sendgrid/sendgrid-ruby/blob/master/CONTRIBUTING.md#submit_a_bug_report)
* [Improvements to the Codebase](https://github.com/sendgrid/sendgrid-ruby/blob/master/CONTRIBUTING.md#improvements_to_the_codebase)

## Usage

- [SendGrid Docs](https://sendgrid.com/docs/API_Reference/index.html)
- [v3 Web API](https://github.com/sendgrid/sendgrid-ruby/blob/master/USAGE.md)
- [Example Code](https://github.com/sendgrid/sendgrid-ruby/blob/master/examples)
- [v3 Web API Mail Send Helper]()

## Unsupported Libraries

- [Official and Unsupported SendGrid Libraries](https://sendgrid.com/docs/Integrate/libraries.html)

# About

![SendGrid Logo]
(https://assets3.sendgrid.com/mkt/assets/logos_brands/small/sglogo_2015_blue-9c87423c2ff2ff393ebce1ab3bd018a4.png)

sendgrid-ruby is guided and supported by the SendGrid [Developer Experience Team](mailto:dx@sendgrid.com).

sendgrid-ruby is maintained and funded by SendGrid, Inc. The names and logos for sendgrid-ruby are trademarks of SendGrid, Inc.

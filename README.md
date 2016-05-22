[![Travis Badge](https://travis-ci.org/sendgrid/sendgrid-ruby.svg?branch=v3beta)](https://travis-ci.org/sendgrid/sendgrid-ruby)


**This library allows you to quickly and easily use the SendGrid Web API via Ruby.**

# Announcements

**NOTE: The `/mail/send/beta` endpoint is currently in beta!

Since this is not a general release, we do not recommend POSTing production level traffic through this endpoint or integrating your production servers with this endpoint.

When this endpoint is ready for general release, your code will require an update in order to use the official URI.

By using this endpoint, you accept that you may encounter bugs and that the endpoint may be taken down for maintenance at any time. We cannot guarantee the continued availability of this beta endpoint. We hope that you like this new endpoint and we appreciate any [feedback](dx+mail-beta@sendgrid.com) that you can send our way.**

**BREAKING CHANGE as of XXXX.XX.XX**

Version `2.0.0` is a breaking change for the entire library.

Version 2.0.0 brings you full support for all Web API v3 endpoints. We
have the following resources to get you started quickly:

-   [SendGrid
    Documentation](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html)
-   [Usage
    Documentation](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/USAGE.md)
-   [Example
    Code](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/examples)

Thank you for your continued support!

All updates to this library is documented in our [CHANGELOG](https://github.com/sendgrid/sendgrid-ruby/blob/v3beta/CHANGELOG.md).

# Installation

## Environment Variables

First, get your free SendGrid account [here](https://sendgrid.com/free?source=sendgrid-ruby).

Next, update your environment with your [SENDGRID_API_KEY](https://app.sendgrid.com/settings/api_keys).

```bash
echo "export SENDGRID_API_KEY='YOUR_API_KEY'" > sendgrid.env
echo "sendgrid.env" >> .gitignore
source ./sendgrid.env
```
## TRYING OUT THE V3 BETA MAIL SEND

```bash
git clone -b v3beta --single-branch https://github.com/sendgrid/sendgrid-ruby.git
cd sendgrid-ruby
```

* Update the to and from [emails](https://github.com/sendgrid/sendgrid-ruby/blob/v3beta/examples/helpers/mail/example.rb#L7).

```bash
ruby examples/helpers/mail/example.rb
```

## TRYING OUT THE V3 BETA WEB API

```bash
git clone -b v3beta --single-branch https://github.com/sendgrid/sendgrid-ruby.git
cd sendgrid-ruby
```

* Check out the documentation for [Web API v3 endpoints](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html).
* Review the [example](https://github.com/sendgrid/sendgrid-ruby/blob/v3beta/examples).

```bash
ruby examples/example.rb
```

* Check out the documentation for [Web API v3 /mail/send/beta endpoint](https://sendgrid.com/docs/API_Reference/Web_API_v3/Mail/index.html).

## Once we are out of v3 BETA, the following will apply

Add this line to your application's Gemfile:

```bash
gem 'sendgrid-ruby'
```

And then execute:

```bash
bundle
```

Or install it yourself using:

```bash
gem install sendgrid-ruby
```

## Dependencies

- The SendGrid Service, starting at the [free level](https://sendgrid.com/free?source=sendgrid-ruby))
- [Ruby-HTTP-Client](https://github.com/sendgrid/ruby-http-client)

# Quick Start

## Hello Email

```ruby
require 'sendgrid-ruby'

from = Email.new(email: 'test@example.com')
subject = 'Hello World from the SendGrid Ruby Library'
to = Email.new(email: 'test@example.com')
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

# Usage

- [SendGrid Docs](https://sendgrid.com/docs/API_Reference/index.html)
- [Example Code](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/examples)

## Roadmap

If you are interested in the future direction of this project, please take a look at our [milestones](
). We would love to hear your feedback.

## How to Contribute

We encourage contribution to our libraries, please see our [CONTRIBUTING](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/CONTRIBUTING.md) guide for details.

- [Feature Request](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/CONTRIBUTING.md#feature_request)
- [Bug Reports](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/CONTRIBUTING.md#submit_a_bug_report)
- [Sign the CLA to Create a Pull Request](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/CONTRIBUTING.md#cla)
- [Improvements to the Codebase](https://github.com/sendgrid/sendgrid-ruby/tree/v3beta/CONTRIBUTING.md#improvements_to_the_codebase)

# About

sendgrid-ruby is guided and supported by the SendGrid [Developer Experience Team](mailto:dx@sendgrid.com).

sendgrid-ruby is maintained and funded by SendGrid, Inc. The names and logos for sendgrid-ruby are trademarks of SendGrid, Inc.

![SendGrid Logo]
(https://assets3.sendgrid.com/mkt/assets/logos_brands/small/sglogo_2015_blue-9c87423c2ff2ff393ebce1ab3bd018a4.png)
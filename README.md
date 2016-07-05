[![Travis Badge](https://travis-ci.org/sendgrid/sendgrid-ruby.svg?branch=master)](https://travis-ci.org/sendgrid/sendgrid-ruby)


**This library allows you to quickly and easily use the SendGrid Web API via Ruby.**

# Announcements

**BREAKING CHANGE as of 2016.06.14**

Version `2.0.0` is a breaking change for the entire library.

Version 2.0.0 brings you full support for all Web API v3 endpoints. We
have the following resources to get you started quickly:

-   [SendGrid
    Documentation](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html)
-   [Usage
    Documentation](https://github.com/sendgrid/sendgrid-ruby/tree/master/USAGE.md)
-   [Example
    Code](https://github.com/sendgrid/sendgrid-ruby/tree/master/examples)

Thank you for your continued support!

All updates to this library is documented in our [CHANGELOG](https://github.com/sendgrid/sendgrid-ruby/blob/master/CHANGELOG.md).

# Installation

## Setup Environment Variables

First, get your free SendGrid account [here](https://sendgrid.com/free?source=sendgrid-ruby).

Next, update your environment with your [SENDGRID_API_KEY](https://app.sendgrid.com/settings/api_keys).

```bash
echo "export SENDGRID_API_KEY='YOUR_API_KEY'" > sendgrid.env
echo "sendgrid.env" >> .gitignore
source ./sendgrid.env
```
## Install Package

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

- The SendGrid Service, starting at the [free level](https://sendgrid.com/free?source=sendgrid-ruby)
- [Ruby-HTTP-Client](https://github.com/sendgrid/ruby-http-client)

# Quick Start

## Hello Email

```ruby
require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'test@example.com')
subject = 'Hello World from the SendGrid Ruby Library'
to = Email.new(email: 'test@example.com')
content = Content.new(type: 'text/plain', value: 'some text here')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
```
## Manage Account Settings

```ruby
require 'sendgrid-ruby'
include SendGrid

sg_client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
settings = SendGrid::Settings.new(sendgrid_client: sg_client)

# Fetch settings
response = settings.bcc
puts response.status_code
puts response.body
puts response.headers

# Update bcc settings
response = settings.update_bcc(enabled: true, email: "email@example.com")
puts response.status_code
puts response.body
puts response.headers
```

## General v3 Web API Usage

```ruby
require 'sendgrid-ruby'
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.api_keys.get()
puts response.status_code
puts response.body
puts response.headers
```

# Usage

- [SendGrid Docs](https://sendgrid.com/docs/API_Reference/index.html)
- [Usage Docs](https://github.com/sendgrid/sendgrid-ruby/tree/master/USAGE.md)
- [Example Code](https://github.com/sendgrid/sendgrid-ruby/tree/master/examples)

## Roadmap

If you are interested in the future direction of this project, please take a look at our [milestones](
). We would love to hear your feedback.

## How to Contribute

We encourage contribution to our libraries, please see our [CONTRIBUTING](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md) guide for details.

- [Feature Request](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#feature_request)
- [Bug Reports](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#submit_a_bug_report)
- [Sign the CLA to Create a Pull Request](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#cla)
- [Improvements to the Codebase](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#improvements_to_the_codebase)

# About

sendgrid-ruby is guided and supported by the SendGrid [Developer Experience Team](mailto:dx@sendgrid.com).

sendgrid-ruby is maintained and funded by SendGrid, Inc. The names and logos for sendgrid-ruby are trademarks of SendGrid, Inc.

![SendGrid Logo]
(https://uiux.s3.amazonaws.com/2016-logos/email-logo%402x.png)

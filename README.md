![Twilio SendGrid Logo](https://github.com/sendgrid/sendgrid-python/raw/master/twilio_sendgrid_logo.png)

[![Travis Badge](https://travis-ci.org/sendgrid/sendgrid-ruby.svg?branch=master)](https://travis-ci.org/sendgrid/sendgrid-ruby) 
[![Gem Version](https://badge.fury.io/rb/sendgrid-ruby.svg)](https://badge.fury.io/rb/sendgrid-ruby)
[![Email Notifications Badge](https://dx.sendgrid.com/badge/ruby)](https://dx.sendgrid.com/newsletter/ruby)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)
[![Twitter Follow](https://img.shields.io/twitter/follow/sendgrid.svg?style=social&label=Follow)](https://twitter.com/sendgrid)
[![GitHub contributors](https://img.shields.io/github/contributors/sendgrid/sendgrid-ruby.svg)](https://github.com/sendgrid/sendgrid-ruby/graphs/contributors)
[![Open Source Helpers](https://www.codetriage.com/sendgrid/sendgrid-ruby/badges/users.svg)](https://www.codetriage.com/sendgrid/sendgrid-ruby)

**NEW:** Subscribe to email [notifications](https://dx.sendgrid.com/newsletter/ruby) for releases and breaking changes.

**This library allows you to quickly and easily use the Twilio SendGrid Web API v3 via Ruby.**

Version 3.X.X+ of this library provides full support for all Twilio SendGrid [Web API v3](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html) endpoints, including the new [v3 /mail/send](https://sendgrid.com/blog/introducing-v3mailsend-sendgrids-new-mail-endpoint).

This library represents the beginning of a new path for Twilio SendGrid. We want this library to be community driven and Twilio SendGrid led. We need your help to realize this goal. To help make sure we are building the right things in the right order, we ask that you create [issues](https://github.com/sendgrid/sendgrid-ruby/issues) and [pull requests](https://github.com/sendgrid/sendgrid-ruby/blob/master/CONTRIBUTING.md) or simply upvote or comment on existing issues or pull requests.

Please browse the rest of this README for further details.

We appreciate your continued support, thank you!

# Table of Contents

* [Announcements](#announcements)
* [Installation](#installation)
* [Quick Start](#quick-start)
* [Processing Inbound Email](#inbound)
* [Usage](#usage)
* [Use Cases](#use_cases)
* [Announcements](#announcements)
* [Roadmap](#roadmap)
* [How to Contribute](#contribute)
* [Troubleshooting](#troubleshooting)
* [About](#about)
* [License](#license)

<a name="announcements"></a>
# Announcements

**NEW:** If you're a software engineer who is passionate about #DeveloperExperience and/or #OpenSource, [this is an incredible opportunity to join our #DX team](https://sendgrid.com/careers/role/1421152/?gh_jid=1421152) as a Developer Experience Engineer and work with [@thinkingserious](https://github.com/thinkingserious) and [@aroach](https://github.com/aroach)! Tell your friends :)


<a name="installation"></a>
# Installation

## Prerequisites

- Ruby version >= 2.2 (except version [2.6.0](https://github.com/sendgrid/sendgrid-ruby/blob/master/TROUBLESHOOTING.md#ruby-versions))
- The Twilio SendGrid service, starting at the [free level](https://sendgrid.com/free?source=sendgrid-ruby)

## Setup Environment Variables

Update the development environment with your [SENDGRID_API_KEY](https://app.sendgrid.com/settings/api_keys), for example:

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

- [Ruby-HTTP-Client](https://github.com/sendgrid/ruby-http-client)

<a name="quick-start"></a>
# Quick Start

## Hello Email

The following is the minimum needed code to send an email with the [/mail/send Helper](https://github.com/sendgrid/sendgrid-ruby/tree/master/lib/sendgrid/helpers/mail) ([here](https://github.com/sendgrid/sendgrid-ruby/blob/master/examples/helpers/mail/example.rb#L21) is a full example):

### With Mail Helper Class

```ruby
require 'sendgrid-ruby'
include SendGrid

from = SendGrid::Email.new(email: 'test@example.com')
to = SendGrid::Email.new(email: 'test@example.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
```

For more complex scenarios, please do not use the above constructor and instead build your own personalization object as [demonstrated here](https://github.com/sendgrid/sendgrid-ruby/blob/master/examples/helpers/mail/example.rb#L21).

### Without Mail Helper Class

The following is the minimum needed code to send an email without the /mail/send Helper ([here](https://github.com/sendgrid/sendgrid-ruby/blob/master/examples/mail/mail.rb#L26) is a full example):

```ruby
require 'sendgrid-ruby'
include SendGrid

data = JSON.parse('{
  "personalizations": [
    {
      "to": [
        {
          "email": "test@example.com"
        }
      ],
      "subject": "Sending with Twilio SendGrid is Fun"
    }
  ],
  "from": {
    "email": "test@example.com"
  },
  "content": [
    {
      "type": "text/plain",
      "value": "and easy to do anywhere, even with Ruby"
    }
  ]
}')
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._("send").post(request_body: data)
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
```

## General v3 Web API Usage (With Fluent Interface)

```ruby
require 'sendgrid-ruby'
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.suppression.bounces.get()
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
```

## General v3 Web API Usage (Without Fluent Interface)

```ruby
require 'sendgrid-ruby'
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client._("suppression/bounces").get()
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
```

<a name="inbound"></a>
# Processing Inbound Email

Please see [our helper](https://github.com/sendgrid/sendgrid-ruby/tree/master/lib/sendgrid/helpers/inbound) for utilizing our Inbound Parse webhook.

<a name="usage"></a>
# Usage

- [Twilio SendGrid Docs](https://sendgrid.com/docs/API_Reference/index.html)
- [Library Usage Docs](https://github.com/sendgrid/sendgrid-ruby/tree/master/USAGE.md)
- [Example Code](https://github.com/sendgrid/sendgrid-ruby/tree/master/examples)
- [How-to: Migration from v2 to v3](https://sendgrid.com/docs/Classroom/Send/v3_Mail_Send/how_to_migrate_from_v2_to_v3_mail_send.html)
- [v3 Web API Mail Send Helper](https://github.com/sendgrid/sendgrid-ruby/tree/master/lib/sendgrid/helpers/mail) - build a request object payload for a v3 /mail/send API call.
- [Settings Helper](https://github.com/sendgrid/sendgrid-ruby/tree/master/lib/sendgrid/helpers/settings)

<a name="use_cases"></a>
# Use Cases

[Examples of common API use cases](https://github.com/sendgrid/sendgrid-ruby/blob/master/USE_CASES.md), such as how to send an email with a transactional template.

<a name="announcements"></a>
# Announcements

Please see our announcement regarding [breaking changes](https://github.com/sendgrid/sendgrid-ruby/issues/94). Your support is appreciated!

All updates to this library are documented in our [CHANGELOG](https://github.com/sendgrid/sendgrid-ruby/blob/master/CHANGELOG.md) and [releases](https://github.com/sendgrid/sendgrid-ruby/releases). You may also subscribe to email [release notifications](https://dx.sendgrid.com/newsletter/ruby) for releases and breaking changes.

<a name="roadmap"></a>
# Roadmap

If you are interested in the future direction of this project, please take a look at our open [issues](https://github.com/sendgrid/sendgrid-ruby/issues) and [pull requests](https://github.com/sendgrid/sendgrid-ruby/pulls). We would love to hear your feedback.

<a name="contribute"></a>
# How to Contribute

We encourage contribution to our libraries (you might even score some nifty swag), please see our [CONTRIBUTING](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md) guide for details.

- [Feature Request](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#feature_request)
- [Bug Reports](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#submit_a_bug_report)
- [Sign the CLA to Create a Pull Request](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#cla)
- [Improvements to the Codebase](https://github.com/sendgrid/sendgrid-ruby/tree/master/CONTRIBUTING.md#improvements_to_the_codebase)
- [Review Pull Requests](https://github.com/sendgrid/sendgrid-ruby/blob/master/CONTRIBUTING.md#code-reviews)

<a name="troubleshooting"></a>
# Troubleshooting

Please see our [troubleshooting guide](https://github.com/sendgrid/sendgrid-ruby/blob/master/TROUBLESHOOTING.md) for common library issues.

<a name="about"></a>
# About

sendgrid-ruby is guided and supported by the [Developer Experience Team](mailto:dx@sendgrid.com).

sendgrid-ruby is maintained and funded by SendGrid, Inc. The names and logos for sendgrid-ruby are trademarks of SendGrid, Inc.

<a name="license"></a>
# License
[The MIT License (MIT)](LICENSE.txt)

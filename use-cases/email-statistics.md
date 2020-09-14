# How to View Email Statistics

You can find documentation for how to view your email statistics via the UI [here](https://app.sendgrid.com/statistics) and via API [here](../USAGE.md#stats).

Alternatively, we can post events to a URL of your choice via our [Event Webhook](https://sendgrid.com/docs/API_Reference/Webhooks/event.html) about events that occur as Twilio SendGrid processes your email.

You can also use the email statistics helper to make it easier to interact with the API.

```ruby
require 'sendgrid-ruby'
require 'date'

include SendGrid

sg_client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
stats = SendGrid::EmailStats.new(sendgrid_client: sg_client)

# Fetch stats by day, between 2 dates
from = Date.new(2017, 10, 01)
to = Date.new(2017, 10, 12)

email_stats = stats.by_day(from, to)

email_stats.metrics

if !email_stats.error?
  email_stats.metrics.each do |metric|
    puts "Date - #{metric.date}"
    puts "Number of Requests - #{metric.requests}"
    puts "Bounces - #{metric.bounces}"
    puts "Opens - #{metric.opens}"
    puts "Clicks - #{metric.clicks}"
  end
end

# Fetch stats by week, between 2 dates for a category
from = Date.new(2017, 10, 01)
to = Date.new(2017, 10, 12)
category = 'abcd'

email_stats = stats.by_week(from, to, category)

if !email_stats.error?
  email_stats.metrics.each do |metric|
    puts "Date - #{metric.date}"
    puts "Number of Requests - #{metric.requests}"
    puts "Bounces - #{metric.bounces}"
    puts "Opens - #{metric.opens}"
    puts "Clicks - #{metric.clicks}"
  end
end
```

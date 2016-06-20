require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve Tracking Settings #
# GET /tracking_settings #

params = JSON.parse('{"limit": 1, "offset": 1}')
response = sg.client.tracking_settings.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Click Tracking Settings #
# PATCH /tracking_settings/click #

data = JSON.parse('{
  "enabled": true
}')
response = sg.client.tracking_settings.click.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Click Track Settings #
# GET /tracking_settings/click #

response = sg.client.tracking_settings.click.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Google Analytics Settings #
# PATCH /tracking_settings/google_analytics #

data = JSON.parse('{
  "enabled": true, 
  "utm_campaign": "website", 
  "utm_content": "", 
  "utm_medium": "email", 
  "utm_source": "sendgrid.com", 
  "utm_term": ""
}')
response = sg.client.tracking_settings.google_analytics.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Google Analytics Settings #
# GET /tracking_settings/google_analytics #

response = sg.client.tracking_settings.google_analytics.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Open Tracking Settings #
# PATCH /tracking_settings/open #

data = JSON.parse('{
  "enabled": true
}')
response = sg.client.tracking_settings.open.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get Open Tracking Settings #
# GET /tracking_settings/open #

response = sg.client.tracking_settings.open.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Subscription Tracking Settings #
# PATCH /tracking_settings/subscription #

data = JSON.parse('{
  "enabled": true, 
  "html_content": "html content", 
  "landing": "landing page html", 
  "plain_content": "text content", 
  "replace": "replacement tag", 
  "url": "url"
}')
response = sg.client.tracking_settings.subscription.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Subscription Tracking Settings #
# GET /tracking_settings/subscription #

response = sg.client.tracking_settings.subscription.get()
puts response.status_code
puts response.body
puts response.headers


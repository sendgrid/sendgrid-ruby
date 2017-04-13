require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Get a user's account information. #
# GET /user/account #

response = sg.client.user.account.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve your credit balance #
# GET /user/credits #

response = sg.client.user.credits.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update your account email address #
# PUT /user/email #

data = JSON.parse('{
  "email": "example@example.com"
}')
response = sg.client.user.email.put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve your account email address #
# GET /user/email #

response = sg.client.user.email.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update your password #
# PUT /user/password #

data = JSON.parse('{
  "new_password": "new_password", 
  "old_password": "old_password"
}')
response = sg.client.user.password.put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update a user's profile #
# PATCH /user/profile #

data = JSON.parse('{
  "city": "Orange", 
  "first_name": "Example", 
  "last_name": "User"
}')
response = sg.client.user.profile.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get a user's profile #
# GET /user/profile #

response = sg.client.user.profile.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Cancel or pause a scheduled send #
# POST /user/scheduled_sends #

data = JSON.parse('{
  "batch_id": "YOUR_BATCH_ID", 
  "status": "pause"
}')
response = sg.client.user.scheduled_sends.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all scheduled sends #
# GET /user/scheduled_sends #

response = sg.client.user.scheduled_sends.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update user scheduled send information #
# PATCH /user/scheduled_sends/{batch_id} #

data = JSON.parse('{
  "status": "pause"
}')
batch_id = "test_url_param"
response = sg.client.user.scheduled_sends._(batch_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve scheduled send #
# GET /user/scheduled_sends/{batch_id} #

batch_id = "test_url_param"
response = sg.client.user.scheduled_sends._(batch_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a cancellation or pause of a scheduled send #
# DELETE /user/scheduled_sends/{batch_id} #

batch_id = "test_url_param"
response = sg.client.user.scheduled_sends._(batch_id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Enforced TLS settings #
# PATCH /user/settings/enforced_tls #

data = JSON.parse('{
  "require_tls": true, 
  "require_valid_cert": false
}')
response = sg.client.user.settings.enforced_tls.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve current Enforced TLS settings. #
# GET /user/settings/enforced_tls #

response = sg.client.user.settings.enforced_tls.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update your username #
# PUT /user/username #

data = JSON.parse('{
  "username": "test_username"
}')
response = sg.client.user.username.put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve your username #
# GET /user/username #

response = sg.client.user.username.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Event Notification Settings #
# PATCH /user/webhooks/event/settings #

data = JSON.parse('{
  "bounce": true, 
  "click": true, 
  "deferred": true, 
  "delivered": true, 
  "dropped": true, 
  "enabled": true, 
  "group_resubscribe": true, 
  "group_unsubscribe": true, 
  "open": true, 
  "processed": true, 
  "spam_report": true, 
  "unsubscribe": true, 
  "url": "url"
}')
response = sg.client.user.webhooks.event.settings.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Event Webhook settings #
# GET /user/webhooks/event/settings #

response = sg.client.user.webhooks.event.settings.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Test Event Notification Settings  #
# POST /user/webhooks/event/test #

data = JSON.parse('{
  "url": "url"
}')
response = sg.client.user.webhooks.event.test.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Create a parse setting #
# POST /user/webhooks/parse/settings #

data = JSON.parse('{
  "hostname": "myhostname.com", 
  "send_raw": false, 
  "spam_check": true, 
  "url": "http://email.myhosthame.com"
}')
response = sg.client.user.webhooks.parse.settings.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all parse settings #
# GET /user/webhooks/parse/settings #

response = sg.client.user.webhooks.parse.settings.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update a parse setting #
# PATCH /user/webhooks/parse/settings/{hostname} #

data = JSON.parse('{
  "send_raw": true, 
  "spam_check": false, 
  "url": "http://newdomain.com/parse"
}')
hostname = "test_url_param"
response = sg.client.user.webhooks.parse.settings._(hostname).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific parse setting #
# GET /user/webhooks/parse/settings/{hostname} #

hostname = "test_url_param"
response = sg.client.user.webhooks.parse.settings._(hostname).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a parse setting #
# DELETE /user/webhooks/parse/settings/{hostname} #

hostname = "test_url_param"
response = sg.client.user.webhooks.parse.settings._(hostname).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieves Inbound Parse Webhook statistics. #
# GET /user/webhooks/parse/stats #

params = JSON.parse('{"aggregated_by": "day", "limit": "test_string", "start_date": "2016-01-01", "end_date": "2016-04-01", "offset": "test_string"}')
response = sg.client.user.webhooks.parse.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


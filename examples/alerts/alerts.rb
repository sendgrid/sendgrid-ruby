require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Create a new Alert #
# POST /alerts #

data = JSON.parse('{
  "email_to": "example@example.com", 
  "frequency": "daily", 
  "type": "stats_notification"
}')
response = sg.client.alerts.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all alerts #
# GET /alerts #

response = sg.client.alerts.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update an alert #
# PATCH /alerts/{alert_id} #

data = JSON.parse('{
  "email_to": "example@example.com"
}')
alert_id = "test_url_param"
response = sg.client.alerts._(alert_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific alert #
# GET /alerts/{alert_id} #

alert_id = "test_url_param"
response = sg.client.alerts._(alert_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete an alert #
# DELETE /alerts/{alert_id} #

alert_id = "test_url_param"
response = sg.client.alerts._(alert_id).delete()
puts response.status_code
puts response.body
puts response.headers


require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve all blocks #
# GET /suppression/blocks #

params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
response = sg.client.suppression.blocks.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete blocks #
# DELETE /suppression/blocks #

data = JSON.parse('{
  "delete_all": false,
  "emails": [
    "example1@example.com",
    "example2@example.com"
  ]
}')
response = sg.client.suppression.blocks.delete(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific block #
# GET /suppression/blocks/{email} #

email = "test_url_param"
response = sg.client.suppression.blocks._(email).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a specific block #
# DELETE /suppression/blocks/{email} #

email = "test_url_param"
response = sg.client.suppression.blocks._(email).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all bounces #
# GET /suppression/bounces #

params = JSON.parse('{"start_time": 1, "end_time": 1}')
response = sg.client.suppression.bounces.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete bounces #
# DELETE /suppression/bounces #

data = JSON.parse('{
  "delete_all": true,
  "emails": [
    "example@example.com",
    "example2@example.com"
  ]
}')
response = sg.client.suppression.bounces.delete(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a Bounce #
# GET /suppression/bounces/{email} #

email = "test_url_param"
response = sg.client.suppression.bounces._(email).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a bounce #
# DELETE /suppression/bounces/{email} #

params = JSON.parse('{"email_address": "example@example.com"}')
email = "test_url_param"
response = sg.client.suppression.bounces._(email).delete(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all invalid emails #
# GET /suppression/invalid_emails #

params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
response = sg.client.suppression.invalid_emails.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete invalid emails #
# DELETE /suppression/invalid_emails #

data = JSON.parse('{
  "delete_all": false,
  "emails": [
    "example1@example.com",
    "example2@example.com"
  ]
}')
response = sg.client.suppression.invalid_emails.delete(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific invalid email #
# GET /suppression/invalid_emails/{email} #

email = "test_url_param"
response = sg.client.suppression.invalid_emails._(email).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a specific invalid email #
# DELETE /suppression/invalid_emails/{email} #

email = "test_url_param"
response = sg.client.suppression.invalid_emails._(email).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific spam report #
# GET /suppression/spam_report/{email} #

email = "test_url_param"
response = sg.client.suppression.spam_reports._(email).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a specific spam report #
# DELETE /suppression/spam_report/{email} #

email = "test_url_param"
response = sg.client.suppression.spam_reports._(email).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all spam reports #
# GET /suppression/spam_reports #

params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
response = sg.client.suppression.spam_reports.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete spam reports #
# DELETE /suppression/spam_reports #

data = JSON.parse('{
  "delete_all": false,
  "emails": [
    "example1@example.com",
    "example2@example.com"
  ]
}')
response = sg.client.suppression.spam_reports.delete(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all global suppressions #
# GET /suppression/unsubscribes #

params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
response = sg.client.suppression.unsubscribes.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


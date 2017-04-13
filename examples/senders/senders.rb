require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Create a Sender Identity #
# POST /senders #

data = JSON.parse('{
  "address": "123 Elm St.", 
  "address_2": "Apt. 456", 
  "city": "Denver", 
  "country": "United States", 
  "from": {
    "email": "from@example.com", 
    "name": "Example INC"
  }, 
  "nickname": "My Sender ID", 
  "reply_to": {
    "email": "replyto@example.com", 
    "name": "Example INC"
  }, 
  "state": "Colorado", 
  "zip": "80202"
}')
response = sg.client.senders.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get all Sender Identities #
# GET /senders #

response = sg.client.senders.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update a Sender Identity #
# PATCH /senders/{sender_id} #

data = JSON.parse('{
  "address": "123 Elm St.", 
  "address_2": "Apt. 456", 
  "city": "Denver", 
  "country": "United States", 
  "from": {
    "email": "from@example.com", 
    "name": "Example INC"
  }, 
  "nickname": "My Sender ID", 
  "reply_to": {
    "email": "replyto@example.com", 
    "name": "Example INC"
  }, 
  "state": "Colorado", 
  "zip": "80202"
}')
sender_id = "test_url_param"
response = sg.client.senders._(sender_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# View a Sender Identity #
# GET /senders/{sender_id} #

sender_id = "test_url_param"
response = sg.client.senders._(sender_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a Sender Identity #
# DELETE /senders/{sender_id} #

sender_id = "test_url_param"
response = sg.client.senders._(sender_id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Resend Sender Identity Verification #
# POST /senders/{sender_id}/resend_verification #

sender_id = "test_url_param"
response = sg.client.senders._(sender_id).resend_verification.post()
puts response.status_code
puts response.body
puts response.headers


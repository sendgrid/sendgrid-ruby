require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Create API keys #
# POST /api_keys #

data = JSON.parse('{
  "name": "My API Key", 
  "scopes": [
    "mail.send", 
    "alerts.create", 
    "alerts.read"
  ]
}')
response = sg.client.api_keys.post(request_body: data)
puts response.status_code
puts response.response_body
puts response.response_headers

##################################################
# Retrieve all API Keys belonging to the authenticated user #
# GET /api_keys #

response = sg.client.api_keys.get()
puts response.status_code
puts response.response_body
puts response.response_headers

##################################################
# Update the name & scopes of an API Key #
# PUT /api_keys/{api_key_id} #

data = JSON.parse('{
  "name": "A New Hope", 
  "scopes": [
    "user.profile.read", 
    "user.profile.update"
  ]
}')
api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).put(request_body: data)
puts response.status_code
puts response.response_body
puts response.response_headers

##################################################
# Update API keys #
# PATCH /api_keys/{api_key_id} #

data = JSON.parse('{
  "name": "A New Hope"
}')
api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).patch(request_body: data)
puts response.status_code
puts response.response_body
puts response.response_headers

##################################################
# Retrieve an existing API Key #
# GET /api_keys/{api_key_id} #

api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).get()
puts response.status_code
puts response.response_body
puts response.response_headers

##################################################
# Delete API keys #
# DELETE /api_keys/{api_key_id} #

api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).delete()
puts response.status_code
puts response.response_body
puts response.response_headers


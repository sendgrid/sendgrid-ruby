require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Create API keys #
# POST /api_keys #

data = JSON.parse('{
  "name": "My API Key", 
  "sample": "data", 
  "scopes": [
    "mail.send", 
    "alerts.create", 
    "alerts.read"
  ]
}')
response = sg.client.api_keys.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all API Keys belonging to the authenticated user #
# GET /api_keys #

params = JSON.parse('{"limit": 1}')
response = sg.client.api_keys.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

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
puts response.body
puts response.headers

##################################################
# Update API keys #
# PATCH /api_keys/{api_key_id} #

data = JSON.parse('{
  "name": "A New Hope"
}')
api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve an existing API Key #
# GET /api_keys/{api_key_id} #

api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete API keys #
# DELETE /api_keys/{api_key_id} #

api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).delete()
puts response.status_code
puts response.body
puts response.headers


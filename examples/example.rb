require_relative '../lib/sendgrid-ruby'

headers = JSON.parse('
  {
    "X-Test": "test"
  }
')
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com', request_headers: headers)

# GET Collection
query_params = { 'limit' => 100, 'offset' => 0 }
response = sg.client.api_keys.get(query_params: query_params)
puts response.status_code
puts response.response_body
puts response.response_headers

# POST
request_body = JSON.parse('
    {
        "name": "My API Key Ruby Test",
        "scopes": [
            "mail.send",
            "alerts.create",
            "alerts.read"
        ]
    }
')
response = sg.client.api_keys.post(request_body: request_body)
puts response.status_code
puts response.response_body
puts response.response_headers
api_key_id = JSON.parse(response.response_body)['api_key_id']

# GET Single
response = sg.client.api_keys._(api_key_id).get
puts response.status_code
puts response.response_body
puts response.response_headers

# PATCH
request_body = JSON.parse('
    {
        "name": "A New Hope"
    }
')
response = sg.client.api_keys._(api_key_id).patch(request_body: request_body)
puts response.status_code
puts response.response_body
puts response.response_headers

# PUT
request_body = JSON.parse('
    {
        "name": "A New Hope",
        "scopes": [
            "user.profile.read",
            "user.profile.update"
        ]
    }
')
response = sg.client.api_keys._(api_key_id).put(request_body: request_body)
puts response.status_code
puts response.response_body
puts response.response_headers

# DELETE
response = sg.client.api_keys._(api_key_id).delete
puts response.status_code
puts response.response_headers

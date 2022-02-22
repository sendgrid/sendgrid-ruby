require 'sendgrid-ruby'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Create List #
# GET /marketing/lists #

data = JSON.parse('{
  "name": "list-name"
}')

response = sg.client.marketing.lists.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get All Lists #
# GET /marketing/lists #

response = sg.client.marketing.lists.get
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get a List by ID #
# GET /marketing/lists/{id} #

list_id = 'ca7a3796-e8a8-4029-9ccb-df8937940562'
response = sg.client.marketing.lists._(list_id).get
puts response.status_code
puts response.body
puts response.headers

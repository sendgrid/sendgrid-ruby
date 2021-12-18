require 'sendgrid-ruby'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Create Custom Field Definition #
# POST /marketing/field_definitions #

data = JSON.parse('{
  "name": "pet",
  "field_type": "Text"
}')

response = sg.client.marketing.field_definitions.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get All Field Definitions #
# GET /marketing/field_definitions #

response = sg.client.marketing.field_definitions.get
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Custom Field Definition #
# PATCH /marketing/field_definitions/{custom_field_id} #

data = JSON.parse('{
  "name": "new_custom_field_name"
}')
custom_field_id = 'e1_T'
response = sg.client.marketing.field_definitions._(custom_field_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete Custom Field Definition #
# DELETE /marketing/field_definitions/{custom_field_id} #

custom_field_id = 'e1_T'
response = sg.client.marketing.field_definitions._(custom_field_id).delete
puts response.status_code
puts response.body
puts response.headers

require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Returns a list of all partner settings. #
# GET /partner_settings #

params = JSON.parse('{"limit": 1, "offset": 1}')
response = sg.client.partner_settings.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Updates New Relic partner settings. #
# PATCH /partner_settings/new_relic #

data = JSON.parse('{
  "enable_subuser_statistics": true, 
  "enabled": true, 
  "license_key": ""
}')
response = sg.client.partner_settings.new_relic.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Returns all New Relic partner settings. #
# GET /partner_settings/new_relic #

response = sg.client.partner_settings.new_relic.get()
puts response.status_code
puts response.body
puts response.headers


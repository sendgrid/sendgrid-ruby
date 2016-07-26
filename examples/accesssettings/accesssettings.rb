require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve all recent access attempts #
# GET /access_settings/activity #

params = JSON.parse('{"limit": 1}')
response = sg.client.access_settings.activity.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Add one or more IPs to the whitelist #
# POST /access_settings/whitelist #

data = JSON.parse('{
  "ips": [
    {
      "ip": "192.168.1.1"
    }, 
    {
      "ip": "192.*.*.*"
    }, 
    {
      "ip": "192.168.1.3/32"
    }
  ]
}')
response = sg.client.access_settings.whitelist.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a list of currently whitelisted IPs #
# GET /access_settings/whitelist #

response = sg.client.access_settings.whitelist.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Remove one or more IPs from the whitelist #
# DELETE /access_settings/whitelist #

data = JSON.parse('{
  "ids": [
    1, 
    2, 
    3
  ]
}')
response = sg.client.access_settings.whitelist.delete(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific whitelisted IP #
# GET /access_settings/whitelist/{rule_id} #

rule_id = "test_url_param"
response = sg.client.access_settings.whitelist._(rule_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Remove a specific IP from the whitelist #
# DELETE /access_settings/whitelist/{rule_id} #

rule_id = "test_url_param"
response = sg.client.access_settings.whitelist._(rule_id).delete()
puts response.status_code
puts response.body
puts response.headers


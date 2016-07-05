require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Create Subuser #
# POST /subusers #

data = JSON.parse('{
  "email": "John@example.com", 
  "ips": [
    "1.1.1.1", 
    "2.2.2.2"
  ], 
  "password": "johns_password", 
  "username": "John@example.com"
}')
response = sg.client.subusers.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# List all Subusers #
# GET /subusers #

params = JSON.parse('{"username": "test_string", "limit": 1, "offset": 1}')
response = sg.client.subusers.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Subuser Reputations #
# GET /subusers/reputations #

params = JSON.parse('{"usernames": "test_string"}')
response = sg.client.subusers.reputations.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve email statistics for your subusers. #
# GET /subusers/stats #

params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01", "subusers": "test_string"}')
response = sg.client.subusers.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve monthly stats for all subusers #
# GET /subusers/stats/monthly #

params = JSON.parse('{"subuser": "test_string", "limit": 1, "sort_by_metric": "test_string", "offset": 1, "date": "test_string", "sort_by_direction": "asc"}')
response = sg.client.subusers.stats.monthly.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
#  Retrieve the totals for each email statistic metric for all subusers. #
# GET /subusers/stats/sums #

params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "sort_by_metric": "test_string", "offset": 1, "start_date": "2016-01-01", "sort_by_direction": "asc"}')
response = sg.client.subusers.stats.sums.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Enable/disable a subuser #
# PATCH /subusers/{subuser_name} #

data = JSON.parse('{
  "disabled": false
}')
subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a subuser #
# DELETE /subusers/{subuser_name} #

subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update IPs assigned to a subuser #
# PUT /subusers/{subuser_name}/ips #

data = JSON.parse('[
  "127.0.0.1"
]')
subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).ips.put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update Monitor Settings for a subuser #
# PUT /subusers/{subuser_name}/monitor #

data = JSON.parse('{
  "email": "example@example.com", 
  "frequency": 500
}')
subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).monitor.put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Create monitor settings #
# POST /subusers/{subuser_name}/monitor #

data = JSON.parse('{
  "email": "example@example.com", 
  "frequency": 50000
}')
subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).monitor.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve monitor settings for a subuser #
# GET /subusers/{subuser_name}/monitor #

subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).monitor.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete monitor settings #
# DELETE /subusers/{subuser_name}/monitor #

subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).monitor.delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve the monthly email statistics for a single subuser #
# GET /subusers/{subuser_name}/stats/monthly #

params = JSON.parse('{"date": "test_string", "sort_by_direction": "asc", "limit": 1, "sort_by_metric": "test_string", "offset": 1}')
subuser_name = "test_url_param"
response = sg.client.subusers._(subuser_name).stats.monthly.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


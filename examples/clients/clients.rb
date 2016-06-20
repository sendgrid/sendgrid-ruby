require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve email statistics by client type. #
# GET /clients/stats #

params = JSON.parse('{"aggregated_by": "day", "start_date": "2016-01-01", "end_date": "2016-04-01"}')
response = sg.client.clients.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve stats by a specific client type. #
# GET /clients/{client_type}/stats #

params = JSON.parse('{"aggregated_by": "day", "start_date": "2016-01-01", "end_date": "2016-04-01"}')
client_type = "test_url_param"
response = sg.client.clients._(client_type).stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


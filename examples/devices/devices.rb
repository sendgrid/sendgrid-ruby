require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve email statistics by device type. #
# GET /devices/stats #

params = JSON.parse('{"aggregated_by": "day", "limit": 1, "start_date": "2016-01-01", "end_date": "2016-04-01", "offset": 1}')
response = sg.client.devices.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


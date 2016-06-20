require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve email statistics by browser.  #
# GET /browsers/stats #

params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "browsers": "test_string", "limit": "test_string", "offset": "test_string", "start_date": "2016-01-01"}')
response = sg.client.browsers.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


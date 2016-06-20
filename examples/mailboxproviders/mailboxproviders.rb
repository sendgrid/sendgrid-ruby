require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve email statistics by mailbox provider. #
# GET /mailbox_providers/stats #

params = JSON.parse('{"end_date": "2016-04-01", "mailbox_providers": "test_string", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01"}')
response = sg.client.mailbox_providers.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


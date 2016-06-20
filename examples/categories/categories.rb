require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve all categories #
# GET /categories #

params = JSON.parse('{"category": "test_string", "limit": 1, "offset": 1}')
response = sg.client.categories.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Email Statistics for Categories #
# GET /categories/stats #

params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01", "categories": "test_string"}')
response = sg.client.categories.stats.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve sums of email stats for each category [Needs: Stats object defined, has category ID?] #
# GET /categories/stats/sums #

params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "sort_by_metric": "test_string", "offset": 1, "start_date": "2016-01-01", "sort_by_direction": "asc"}')
response = sg.client.categories.stats.sums.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers


require 'sendgrid-ruby'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Filter all messages #
# GET /messages #

require 'erb'

filter_key = 'to_email'
filter_operator = ERB::Util.url_encode('=')
filter_value = 'testing@sendgrid.net'
filter_value = ERB::Util.url_encode(format('"%s"', filter_value))
query_params = {}
query_params['query'] = format("%s%s%s", filter_key, filter_operator, filter_value)
query_params['limit'] = '1'

params = query_params
response = sg.client.messages.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Filter messages by message ID #
# GET /messages/{msg_id} #

msg_id = "test_url_param"
response = sg.client.messages._(msg_id).get
puts response.status_code
puts response.body
puts response.headers

##################################################
# Request a CSV #
# POST /messages/download #

response = sg.client.messages.download.post
puts response.status_code
puts response.body
puts response.headers

##################################################
# Download CSV #
# GET /messages/download/{download_uuid} #

download_uuid = "test_url_param"
response = sg.client.messages.download._(download_uuid).get
puts response.status_code
puts response.body
puts response.headers

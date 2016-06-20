require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve a list of scopes for which this user has access. #
# GET /scopes #

response = sg.client.scopes.get()
puts response.status_code
puts response.body
puts response.headers


require 'sendgrid-ruby'
include SendGrid

sg_client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
settings = SendGrid::Settings.new(sendgrid_client: sg_client)

# Fetch settings
response = settings.bcc
puts response.status_code
puts response.body
puts response.headers

# Turn on bcc settings
response = settings.update_bcc(enabled: true, email: "email@example.com")
puts response.status_code
puts response.body
puts response.headers

# Turn off bcc settings
response = settings.update_bcc(enabled: false)
puts response.status_code
puts response.body
puts response.headers

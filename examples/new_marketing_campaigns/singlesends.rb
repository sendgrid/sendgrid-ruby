require 'sendgrid-ruby'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Create Single Send #
# POST /marketing/singlesends #

data = JSON.parse('{
  "name": "Example API Created Single Send",
  "categories": [
    "unique opens"
  ],
  "send_to": {
    "all": true
  },
  "email_config": {
    "design_id": "<your-design-id>",
    "editor": "design",
    "suppression_group_id": 12,
    "sender_id": 10
  }
}')

response = sg.client.marketing.singlesends.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

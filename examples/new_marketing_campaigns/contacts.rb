require 'sendgrid-ruby'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Add or Update a Contact #
# POST /marketing/contacts #

data = JSON.parse('{
  "list_ids": [
    "ca7a3796-e8a8-4029-9ccb-df8937940562"
  ],
  "contacts": [
    {
      "address_line_1": "123 Elm St.",
      "address_line_2": "Apt. 456",
      "city": "Denver",
      "country": "United States",
      "email": "example@example.com",
      "first_name": "User",
      "last_name": "Example"
    }
  ]
}')

response = sg.client.marketing.contacts.put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

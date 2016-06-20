require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Retrieve all mail settings #
# GET /mail_settings #

params = JSON.parse('{"limit": 1, "offset": 1}')
response = sg.client.mail_settings.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update address whitelist mail settings #
# PATCH /mail_settings/address_whitelist #

data = JSON.parse('{
  "enabled": true, 
  "list": [
    "email1@example.com", 
    "example.com"
  ]
}')
response = sg.client.mail_settings.address_whitelist.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve address whitelist mail settings #
# GET /mail_settings/address_whitelist #

response = sg.client.mail_settings.address_whitelist.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update BCC mail settings #
# PATCH /mail_settings/bcc #

data = JSON.parse('{
  "email": "email@example.com", 
  "enabled": false
}')
response = sg.client.mail_settings.bcc.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all BCC mail settings #
# GET /mail_settings/bcc #

response = sg.client.mail_settings.bcc.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update bounce purge mail settings #
# PATCH /mail_settings/bounce_purge #

data = JSON.parse('{
  "enabled": true, 
  "hard_bounces": 5, 
  "soft_bounces": 5
}')
response = sg.client.mail_settings.bounce_purge.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve bounce purge mail settings #
# GET /mail_settings/bounce_purge #

response = sg.client.mail_settings.bounce_purge.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update footer mail settings #
# PATCH /mail_settings/footer #

data = JSON.parse('{
  "enabled": true, 
  "html_content": "...", 
  "plain_content": "..."
}')
response = sg.client.mail_settings.footer.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve footer mail settings #
# GET /mail_settings/footer #

response = sg.client.mail_settings.footer.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update forward bounce mail settings #
# PATCH /mail_settings/forward_bounce #

data = JSON.parse('{
  "email": "example@example.com", 
  "enabled": true
}')
response = sg.client.mail_settings.forward_bounce.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve forward bounce mail settings #
# GET /mail_settings/forward_bounce #

response = sg.client.mail_settings.forward_bounce.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update forward spam mail settings #
# PATCH /mail_settings/forward_spam #

data = JSON.parse('{
  "email": "", 
  "enabled": false
}')
response = sg.client.mail_settings.forward_spam.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve forward spam mail settings #
# GET /mail_settings/forward_spam #

response = sg.client.mail_settings.forward_spam.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update plain content mail settings #
# PATCH /mail_settings/plain_content #

data = JSON.parse('{
  "enabled": false
}')
response = sg.client.mail_settings.plain_content.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve plain content mail settings #
# GET /mail_settings/plain_content #

response = sg.client.mail_settings.plain_content.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update spam check mail settings #
# PATCH /mail_settings/spam_check #

data = JSON.parse('{
  "enabled": true, 
  "max_score": 5, 
  "url": "url"
}')
response = sg.client.mail_settings.spam_check.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve spam check mail settings #
# GET /mail_settings/spam_check #

response = sg.client.mail_settings.spam_check.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update template mail settings #
# PATCH /mail_settings/template #

data = JSON.parse('{
  "enabled": true, 
  "html_content": "<% body %>"
}')
response = sg.client.mail_settings.template.patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve legacy template mail settings #
# GET /mail_settings/template #

response = sg.client.mail_settings.template.get()
puts response.status_code
puts response.body
puts response.headers


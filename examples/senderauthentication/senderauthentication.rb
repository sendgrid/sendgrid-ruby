require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Create a domain authentication. #
# POST /whitelabel/domains #

data = JSON.parse('{
  "automatic_security": false, 
  "custom_spf": true, 
  "default": true, 
  "domain": "example.com", 
  "ips": [
    "192.168.1.1", 
    "192.168.1.2"
  ], 
  "subdomain": "news", 
  "username": "john@example.com"
}')
response = sg.client.whitelabel.domains.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# List all domain authentications. #
# GET /whitelabel/domains #

params = JSON.parse('{"username": "test_string", "domain": "test_string", "exclude_subusers": "true", "limit": 1, "offset": 1}')
response = sg.client.whitelabel.domains.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Get the default domain authentication. #
# GET /whitelabel/domains/default #

response = sg.client.whitelabel.domains.default.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# List the domain authentication associated with the given user. #
# GET /whitelabel/domains/subuser #

response = sg.client.whitelabel.domains.subuser.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Disassociate a domain authentication from a given user. #
# DELETE /whitelabel/domains/subuser #

response = sg.client.whitelabel.domains.subuser.delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update a domain authentication. #
# PATCH /whitelabel/domains/{domain_id} #

data = JSON.parse('{
  "custom_spf": true, 
  "default": false
}')
domain_id = "test_url_param"
response = sg.client.whitelabel.domains._(domain_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a domain authentication. #
# GET /whitelabel/domains/{domain_id} #

domain_id = "test_url_param"
response = sg.client.whitelabel.domains._(domain_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a domain authentication. #
# DELETE /whitelabel/domains/{domain_id} #

domain_id = "test_url_param"
response = sg.client.whitelabel.domains._(domain_id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Associate a domain authentication with a given user. #
# POST /whitelabel/domains/{domain_id}/subuser #

data = JSON.parse('{
  "username": "jane@example.com"
}')
domain_id = "test_url_param"
response = sg.client.whitelabel.domains._(domain_id).subuser.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Add an IP to a domain authentication. #
# POST /whitelabel/domains/{id}/ips #

data = JSON.parse('{
  "ip": "192.168.0.1"
}')
id = "test_url_param"
response = sg.client.whitelabel.domains._(id).ips.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Remove an IP from a domain authentication. #
# DELETE /whitelabel/domains/{id}/ips/{ip} #

id = "test_url_param"
ip = "test_url_param"
response = sg.client.whitelabel.domains._(id).ips._(ip).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Validate a domain authentication. #
# POST /whitelabel/domains/{id}/validate #

id = "test_url_param"
response = sg.client.whitelabel.domains._(id).validate.post()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Create a reverse DNS record #
# POST /whitelabel/ips #

data = JSON.parse('{
  "domain": "example.com", 
  "ip": "192.168.1.1", 
  "subdomain": "email"
}')
response = sg.client.whitelabel.ips.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a reverse DNS record #
# GET /whitelabel/ips #

params = JSON.parse('{"ip": "test_string", "limit": 1, "offset": 1}')
response = sg.client.whitelabel.ips.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a reverse DNS record #
# GET /whitelabel/ips/{id} #

id = "test_url_param"
response = sg.client.whitelabel.ips._(id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a reverse DNS record #
# DELETE /whitelabel/ips/{id} #

id = "test_url_param"
response = sg.client.whitelabel.ips._(id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Validate a reverse DNS record #
# POST /whitelabel/ips/{id}/validate #

id = "test_url_param"
response = sg.client.whitelabel.ips._(id).validate.post()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Create a Branded Link #
# POST /whitelabel/links #

data = JSON.parse('{
  "default": true, 
  "domain": "example.com", 
  "subdomain": "mail"
}')
params = JSON.parse('{"limit": 1, "offset": 1}')
response = sg.client.whitelabel.links.post(request_body: data, query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all link brandings #
# GET /whitelabel/links #

params = JSON.parse('{"limit": 1}')
response = sg.client.whitelabel.links.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a Default Link Branding #
# GET /whitelabel/links/default #

params = JSON.parse('{"domain": "test_string"}')
response = sg.client.whitelabel.links.default.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve Associated Link Branding #
# GET /whitelabel/links/subuser #

params = JSON.parse('{"username": "test_string"}')
response = sg.client.whitelabel.links.subuser.get(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Disassociate a Link Branding #
# DELETE /whitelabel/links/subuser #

params = JSON.parse('{"username": "test_string"}')
response = sg.client.whitelabel.links.subuser.delete(query_params: params)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update a Link Branding #
# PATCH /whitelabel/links/{id} #

data = JSON.parse('{
  "default": true
}')
id = "test_url_param"
response = sg.client.whitelabel.links._(id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a Link Branding #
# GET /whitelabel/links/{id} #

id = "test_url_param"
response = sg.client.whitelabel.links._(id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a Link Branding #
# DELETE /whitelabel/links/{id} #

id = "test_url_param"
response = sg.client.whitelabel.links._(id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Validate a Link Branding #
# POST /whitelabel/links/{id}/validate #

id = "test_url_param"
response = sg.client.whitelabel.links._(id).validate.post()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Associate a Link Branding #
# POST /whitelabel/links/{link_id}/subuser #

data = JSON.parse('{
  "username": "jane@example.com"
}')
link_id = "test_url_param"
response = sg.client.whitelabel.links._(link_id).subuser.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers


require 'sendgrid-ruby'


sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])


##################################################
# Create a transactional template. #
# POST /templates #

data = JSON.parse('{
  "name": "example_name"
}')
response = sg.client.templates.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve all transactional templates. #
# GET /templates #

response = sg.client.templates.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Edit a transactional template. #
# PATCH /templates/{template_id} #

data = JSON.parse('{
  "name": "new_example_name"
}')
template_id = "test_url_param"
response = sg.client.templates._(template_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a single transactional template. #
# GET /templates/{template_id} #

template_id = "test_url_param"
response = sg.client.templates._(template_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a template. #
# DELETE /templates/{template_id} #

template_id = "test_url_param"
response = sg.client.templates._(template_id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Create a new transactional template version. #
# POST /templates/{template_id}/versions #

data = JSON.parse('{
  "active": 1, 
  "html_content": "<%body%>", 
  "name": "example_version_name", 
  "plain_content": "<%body%>", 
  "subject": "<%subject%>", 
  "template_id": "ddb96bbc-9b92-425e-8979-99464621b543"
}')
template_id = "test_url_param"
response = sg.client.templates._(template_id).versions.post(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Edit a transactional template version. #
# PATCH /templates/{template_id}/versions/{version_id} #

data = JSON.parse('{
  "active": 1, 
  "html_content": "<%body%>", 
  "name": "updated_example_name", 
  "plain_content": "<%body%>", 
  "subject": "<%subject%>"
}')
template_id = "test_url_param"
version_id = "test_url_param"
response = sg.client.templates._(template_id).versions._(version_id).patch(request_body: data)
puts response.status_code
puts response.body
puts response.headers

##################################################
# Retrieve a specific transactional template version. #
# GET /templates/{template_id}/versions/{version_id} #

template_id = "test_url_param"
version_id = "test_url_param"
response = sg.client.templates._(template_id).versions._(version_id).get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Delete a transactional template version. #
# DELETE /templates/{template_id}/versions/{version_id} #

template_id = "test_url_param"
version_id = "test_url_param"
response = sg.client.templates._(template_id).versions._(version_id).delete()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Activate a transactional template version. #
# POST /templates/{template_id}/versions/{version_id}/activate #

template_id = "test_url_param"
version_id = "test_url_param"
response = sg.client.templates._(template_id).versions._(version_id).activate.post()
puts response.status_code
puts response.body
puts response.headers


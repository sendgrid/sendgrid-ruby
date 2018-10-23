require_relative '../../lib/sendgrid-ruby.rb'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

##################################################
# Retrieve a list of scopes for which this user has access. #
# GET /scopes #

response = sg.client.scopes.get()
puts response.status_code
puts response.body
puts response.headers

##################################################
# Update the name & scopes of an API Key #
# PUT /api_keys/{api_key_id} #


scopes = [
  "user.profile.read", 
  "user.profile.update"
]

data = {
  "name": "A New Hope", 
  "scopes": scopes
}
api_key_id = "test_url_param"
response = sg.client.api_keys._(api_key_id).put(request_body: data)
puts response.status_code
puts response.body
puts response.headers

# The above method shows how to update the scopes
# To get various scopes that each of the endpoint has, use the following

# To get all admin permissions
scopes = SendGrid::Scope.admin_permissions

# To get all read only permissions
scopes = SendGrid::Scope.read_only_permissions

# There are two methods for each endpoints, namely
# {endpoint}_read_only_permissions and {endpoint}_full_access_permissions

# These are the endpoints :
# alerts, api_keys, asm_groups, billing, categories, credentials, stats, ips, mail_settings, mail, 
# marketing_campaigns, partner_settings, scheduled_sends, subusers, suppression, teammates, 
# templates, tracking_settings, user_settings, webhooks, whitelabel, access_settings

# read only permissions for alerts
scopes = SendGrid::Scope.alerts_read_only_permissions

# full access permissions for alerts
scopes = SendGrid::Scope.alerts_full_access_permissions

# read only permissions for billing 
scopes = SendGrid::Scope.billing_read_only_permissions

# full access permissions for billing
scopes = SendGrid::Scope.billing_full_access_permissions
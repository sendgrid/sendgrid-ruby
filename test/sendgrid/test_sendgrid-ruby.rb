require 'simplecov'
SimpleCov.start
require_relative '../../lib/sendgrid-ruby.rb'
require 'ruby_http_client'
require 'minitest/autorun'
require 'minitest/unit'

class TestAPI < MiniTest::Test

    def setup
        @sg = SendGrid::API.new(api_key: "SENDGRID_API_KEY")
    end

    def test_init
        headers = JSON.parse('
            {
                "X-Test": "test"
            }
        ')
        subuser = 'test_user'
        sg = SendGrid::API.new(api_key: "SENDGRID_API_KEY", host: "https://api.test.com", request_headers: headers, version: "v3", impersonate_subuser: subuser)

        assert_equal("https://api.test.com", sg.host)
        user_agent       = "sendgrid/#{SendGrid::VERSION};ruby"
        test_headers = JSON.parse('
                {
                    "Authorization": "Bearer SENDGRID_API_KEY",
                    "Accept": "application/json",
                    "X-Test": "test",
                    "User-Agent": "' + user_agent + '",
                    "On-Behalf-Of": "' + subuser + '"
                }
            ')
        assert_equal(test_headers, sg.request_headers)
        assert_equal("v3", sg.version)
        assert_equal(subuser, sg.impersonate_subuser)
        assert_equal("6.3.4", SendGrid::VERSION)
        assert_instance_of(SendGrid::Client, sg.client)
    end

    def test_init_when_impersonate_subuser_is_not_given
        sg = SendGrid::API.new(api_key: "SENDGRID_API_KEY", host: "https://api.test.com", version: "v3")
        refute_includes(sg.request_headers, 'On-Behalf-Of')
    end

    def test_access_settings_activity_get
        params = JSON.parse('{"limit": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.access_settings.activity.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_access_settings_whitelist_post
        data = JSON.parse('{
  "ips": [
    {
      "ip": "192.168.1.1"
    },
    {
      "ip": "192.*.*.*"
    },
    {
      "ip": "192.168.1.3/32"
    }
  ]
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.access_settings.whitelist.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_access_settings_whitelist_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.access_settings.whitelist.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_access_settings_whitelist_delete
        data = JSON.parse('{
  "ids": [
    1,
    2,
    3
  ]
}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.access_settings.whitelist.delete(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_access_settings_whitelist__rule_id__get
        rule_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.access_settings.whitelist._(rule_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_access_settings_whitelist__rule_id__delete
        rule_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.access_settings.whitelist._(rule_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_alerts_post
        data = JSON.parse('{
  "email_to": "example@example.com",
  "frequency": "daily",
  "type": "stats_notification"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.alerts.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_alerts_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.alerts.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_alerts__alert_id__patch
        data = JSON.parse('{
  "email_to": "example@example.com"
}')
        alert_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.alerts._(alert_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_alerts__alert_id__get
        alert_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.alerts._(alert_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_alerts__alert_id__delete
        alert_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.alerts._(alert_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_api_keys_post
        data = JSON.parse('{
  "name": "My API Key",
  "sample": "data",
  "scopes": [
    "mail.send",
    "alerts.create",
    "alerts.read"
  ]
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.api_keys.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_api_keys_get
        params = JSON.parse('{"limit": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.api_keys.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_api_keys__api_key_id__put
        data = JSON.parse('{
  "name": "A New Hope",
  "scopes": [
    "user.profile.read",
    "user.profile.update"
  ]
}')
        api_key_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.api_keys._(api_key_id).put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_api_keys__api_key_id__patch
        data = JSON.parse('{
  "name": "A New Hope"
}')
        api_key_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.api_keys._(api_key_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_api_keys__api_key_id__get
        api_key_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.api_keys._(api_key_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_api_keys__api_key_id__delete
        api_key_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.api_keys._(api_key_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_asm_groups_post
        data = JSON.parse('{
  "description": "Suggestions for products our users might like.",
  "is_default": true,
  "name": "Product Suggestions"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.asm.groups.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_asm_groups_get
        params = JSON.parse('{"id": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.groups.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_asm_groups__group_id__patch
        data = JSON.parse('{
  "description": "Suggestions for items our users might like.",
  "id": 103,
  "name": "Item Suggestions"
}')
        group_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.asm.groups._(group_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_asm_groups__group_id__get
        group_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.groups._(group_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_asm_groups__group_id__delete
        group_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.asm.groups._(group_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_asm_groups__group_id__suppressions_post
        data = JSON.parse('{
  "recipient_emails": [
    "test1@example.com",
    "test2@example.com"
  ]
}')
        group_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.asm.groups._(group_id).suppressions.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_asm_groups__group_id__suppressions_get
        group_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.groups._(group_id).suppressions.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_asm_groups__group_id__suppressions_search_post
        data = JSON.parse('{
  "recipient_emails": [
    "exists1@example.com",
    "exists2@example.com",
    "doesnotexists@example.com"
  ]
}')
        group_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.groups._(group_id).suppressions.search.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_asm_groups__group_id__suppressions__email__delete
        group_id = "test_url_param"
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.asm.groups._(group_id).suppressions._(email).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_asm_suppressions_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.suppressions.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_asm_suppressions_global_post
        data = JSON.parse('{
  "recipient_emails": [
    "test1@example.com",
    "test2@example.com"
  ]
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.asm.suppressions.global.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_asm_suppressions_global__email__get
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.suppressions.global._(email).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_asm_suppressions_global__email__delete
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.asm.suppressions.global._(email).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_asm_suppressions__email__get
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.asm.suppressions._(email).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_browsers_stats_get
        params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "browsers": "test_string", "limit": "test_string", "offset": "test_string", "start_date": "2016-01-01"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.browsers.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_campaigns_post
        data = JSON.parse('{
  "categories": [
    "spring line"
  ],
  "custom_unsubscribe_url": "",
  "html_content": "<html><head><title></title></head><body><p>Check out our spring line!</p></body></html>",
  "ip_pool": "marketing",
  "list_ids": [
    110,
    124
  ],
  "plain_content": "Check out our spring line!",
  "segment_ids": [
    110
  ],
  "sender_id": 124451,
  "subject": "New Products for Spring!",
  "suppression_group_id": 42,
  "title": "March Newsletter"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.campaigns.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_campaigns_get
        params = JSON.parse('{"limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.campaigns.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_campaigns__campaign_id__patch
        data = JSON.parse('{
  "categories": [
    "summer line"
  ],
  "html_content": "<html><head><title></title></head><body><p>Check out our summer line!</p></body></html>",
  "plain_content": "Check out our summer line!",
  "subject": "New Products for Summer!",
  "title": "May Newsletter"
}')
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.campaigns._(campaign_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_campaigns__campaign_id__get
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.campaigns._(campaign_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_campaigns__campaign_id__delete
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.campaigns._(campaign_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_campaigns__campaign_id__schedules_patch
        data = JSON.parse('{
  "send_at": 1489451436
}')
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.campaigns._(campaign_id).schedules.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_campaigns__campaign_id__schedules_post
        data = JSON.parse('{
  "send_at": 1489771528
}')
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.campaigns._(campaign_id).schedules.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_campaigns__campaign_id__schedules_get
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.campaigns._(campaign_id).schedules.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_campaigns__campaign_id__schedules_delete
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.campaigns._(campaign_id).schedules.delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_campaigns__campaign_id__schedules_now_post
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.campaigns._(campaign_id).schedules.now.post(request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_campaigns__campaign_id__schedules_test_post
        data = JSON.parse('{
  "to": "your.email@example.com"
}')
        campaign_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.campaigns._(campaign_id).schedules.test.post(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_categories_get
        params = JSON.parse('{"category": "test_string", "limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.categories.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_categories_stats_get
        params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01", "categories": "test_string"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.categories.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_categories_stats_sums_get
        params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "sort_by_metric": "test_string", "offset": 1, "start_date": "2016-01-01", "sort_by_direction": "asc"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.categories.stats.sums.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_clients_stats_get
        params = JSON.parse('{"aggregated_by": "day", "start_date": "2016-01-01", "end_date": "2016-04-01"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.clients.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_clients__client_type__stats_get
        params = JSON.parse('{"aggregated_by": "day", "start_date": "2016-01-01", "end_date": "2016-04-01"}')
        client_type = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.clients._(client_type).stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_custom_fields_post
        data = JSON.parse('{
  "name": "pet",
  "type": "text"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.contactdb.custom_fields.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_contactdb_custom_fields_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.custom_fields.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_custom_fields__custom_field_id__get
        custom_field_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.custom_fields._(custom_field_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_custom_fields__custom_field_id__delete
        custom_field_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 202}')

        response = @sg.client.contactdb.custom_fields._(custom_field_id).delete(request_headers: headers)

        self.assert_equal('202', response.status_code)
    end

    def test_contactdb_lists_post
        data = JSON.parse('{
  "name": "your list name"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.contactdb.lists.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_contactdb_lists_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.lists.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_lists_delete
        data = JSON.parse('[
  1,
  2,
  3,
  4
]')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.contactdb.lists.delete(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_contactdb_lists__list_id__patch
        data = JSON.parse('{
  "name": "newlistname"
}')
        params = JSON.parse('{"list_id": 1}')
        list_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.lists._(list_id).patch(request_body: data, query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_lists__list_id__get
        params = JSON.parse('{"list_id": 1}')
        list_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.lists._(list_id).get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_lists__list_id__delete
        params = JSON.parse('{"delete_contacts": "true"}')
        list_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 202}')

        response = @sg.client.contactdb.lists._(list_id).delete(query_params: params, request_headers: headers)

        self.assert_equal('202', response.status_code)
    end

    def test_contactdb_lists__list_id__recipients_post
        data = JSON.parse('[
  "recipient_id1",
  "recipient_id2"
]')
        list_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.contactdb.lists._(list_id).recipients.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_contactdb_lists__list_id__recipients_get
        params = JSON.parse('{"page": 1, "page_size": 1, "list_id": 1}')
        list_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.lists._(list_id).recipients.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_lists__list_id__recipients__recipient_id__post
        list_id = "test_url_param"
        recipient_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.contactdb.lists._(list_id).recipients._(recipient_id).post(request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_contactdb_lists__list_id__recipients__recipient_id__delete
        params = JSON.parse('{"recipient_id": 1, "list_id": 1}')
        list_id = "test_url_param"
        recipient_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.contactdb.lists._(list_id).recipients._(recipient_id).delete(query_params: params, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_contactdb_recipients_patch
        data = JSON.parse('[
  {
    "email": "jones@example.com",
    "first_name": "Guy",
    "last_name": "Jones"
  }
]')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.contactdb.recipients.patch(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_contactdb_recipients_post
        data = JSON.parse('[
  {
    "age": 25,
    "email": "example@example.com",
    "first_name": "",
    "last_name": "User"
  },
  {
    "age": 25,
    "email": "example2@example.com",
    "first_name": "Example",
    "last_name": "User"
  }
]')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.contactdb.recipients.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_contactdb_recipients_get
        params = JSON.parse('{"page": 1, "page_size": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_recipients_delete
        data = JSON.parse('[
  "recipient_id1",
  "recipient_id2"
]')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients.delete(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_recipients_billable_count_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients.billable_count.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_recipients_count_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients.count.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_recipients_search_get
        params = { field_name: "test_string" }
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients.search.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_recipients__recipient_id__get
        recipient_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients._(recipient_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_recipients__recipient_id__delete
        recipient_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.contactdb.recipients._(recipient_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_contactdb_recipients__recipient_id__lists_get
        recipient_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.recipients._(recipient_id).lists.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_reserved_fields_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.reserved_fields.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_segments_post
        data = JSON.parse('{
  "conditions": [
    {
      "and_or": "",
      "field": "last_name",
      "operator": "eq",
      "value": "Miller"
    },
    {
      "and_or": "and",
      "field": "last_clicked",
      "operator": "gt",
      "value": "01/02/2015"
    },
    {
      "and_or": "or",
      "field": "clicks.campaign_identifier",
      "operator": "eq",
      "value": "513"
    }
  ],
  "list_id": 4,
  "name": "Last Name Miller"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.segments.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_segments_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.segments.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_segments__segment_id__patch
        data = JSON.parse('{
  "conditions": [
    {
      "and_or": "",
      "field": "last_name",
      "operator": "eq",
      "value": "Miller"
    }
  ],
  "list_id": 5,
  "name": "The Millers"
}')
        params = JSON.parse('{"segment_id": "test_string"}')
        segment_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.segments._(segment_id).patch(request_body: data, query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_segments__segment_id__get
        params = JSON.parse('{"segment_id": 1}')
        segment_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.segments._(segment_id).get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_contactdb_segments__segment_id__delete
        params = JSON.parse('{"delete_contacts": "true"}')
        segment_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.contactdb.segments._(segment_id).delete(query_params: params, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_contactdb_segments__segment_id__recipients_get
        params = JSON.parse('{"page": 1, "page_size": 1}')
        segment_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.contactdb.segments._(segment_id).recipients.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_devices_stats_get
        params = JSON.parse('{"aggregated_by": "day", "limit": 1, "start_date": "2016-01-01", "end_date": "2016-04-01", "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.devices.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_geo_stats_get
        params = JSON.parse('{"end_date": "2016-04-01", "country": "US", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.geo.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_get
        params = JSON.parse('{"subuser": "test_string", "ip": "test_string", "limit": 1, "exclude_whitelabels": "true", "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_assigned_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.assigned.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_pools_post
        data = JSON.parse('{
  "name": "marketing"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.pools.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_pools_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.pools.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_pools__pool_name__put
        data = JSON.parse('{
  "name": "new_pool_name"
}')
        pool_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.pools._(pool_name).put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_pools__pool_name__get
        pool_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.pools._(pool_name).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_pools__pool_name__delete
        pool_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.ips.pools._(pool_name).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_ips_pools__pool_name__ips_post
        data = JSON.parse('{
  "ip": "0.0.0.0"
}')
        pool_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.ips.pools._(pool_name).ips.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_ips_pools__pool_name__ips__ip__delete
        pool_name = "test_url_param"
        ip = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.ips.pools._(pool_name).ips._(ip).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_ips_warmup_post
        data = JSON.parse('{
  "ip": "0.0.0.0"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.warmup.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_warmup_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.warmup.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_warmup__ip_address__get
        ip_address = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips.warmup._(ip_address).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_ips_warmup__ip_address__delete
        ip_address = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.ips.warmup._(ip_address).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_ips__ip_address__get
        ip_address = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.ips._(ip_address).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_batch_post
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.mail.batch.post(request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_mail_batch__batch_id__get
        batch_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail.batch._(batch_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_send_post
        data = JSON.parse('{
  "asm": {
    "group_id": 1,
    "groups_to_display": [
      1,
      2,
      3
    ]
  },
  "attachments": [
    {
      "content": "[BASE64 encoded content block here]",
      "content_id": "ii_139db99fdb5c3704",
      "disposition": "inline",
      "filename": "file1.jpg",
      "name": "file1",
      "type": "jpg"
    }
  ],
  "batch_id": "[YOUR BATCH ID GOES HERE]",
  "categories": [
    "category1",
    "category2"
  ],
  "content": [
    {
      "type": "text/html",
      "value": "<html><p>Hello, world!</p><img src=[CID GOES HERE]></img></html>"
    }
  ],
  "custom_args": {
    "New Argument 1": "New Value 1",
    "activationAttempt": "1",
    "customerAccountNumber": "[CUSTOMER ACCOUNT NUMBER GOES HERE]"
  },
  "from": {
    "email": "sam.smith@example.com",
    "name": "Sam Smith"
  },
  "headers": {},
  "ip_pool_name": "[YOUR POOL NAME GOES HERE]",
  "mail_settings": {
    "bcc": {
      "email": "ben.doe@example.com",
      "enable": true
    },
    "bypass_list_management": {
      "enable": true
    },
    "footer": {
      "enable": true,
      "html": "<p>Thanks</br>The Twilio SendGrid Team</p>",
      "text": "Thanks,/n The Twilio SendGrid Team"
    },
    "sandbox_mode": {
      "enable": false
    },
    "spam_check": {
      "enable": true,
      "post_to_url": "http://example.com/compliance",
      "threshold": 3
    }
  },
  "personalizations": [
    {
      "bcc": [
        {
          "email": "sam.doe@example.com",
          "name": "Sam Doe"
        }
      ],
      "cc": [
        {
          "email": "jane.doe@example.com",
          "name": "Jane Doe"
        }
      ],
      "custom_args": {
        "New Argument 1": "New Value 1",
        "activationAttempt": "1",
        "customerAccountNumber": "[CUSTOMER ACCOUNT NUMBER GOES HERE]"
      },
      "headers": {
        "X-Accept-Language": "en",
        "X-Mailer": "MyApp"
      },
      "send_at": 1409348513,
      "subject": "Hello, World!",
      "substitutions": {
        "id": "substitutions",
        "type": "object"
      },
      "to": [
        {
          "email": "john.doe@example.com",
          "name": "John Doe"
        }
      ]
    }
  ],
  "reply_to": {
    "email": "sam.smith@example.com",
    "name": "Sam Smith"
  },
  "sections": {
    "section": {
      ":sectionName1": "section 1 text",
      ":sectionName2": "section 2 text"
    }
  },
  "send_at": 1409348513,
  "subject": "Hello, World!",
  "template_id": "[YOUR TEMPLATE ID GOES HERE]",
  "tracking_settings": {
    "click_tracking": {
      "enable": true,
      "enable_text": true
    },
    "ganalytics": {
      "enable": true,
      "utm_campaign": "[NAME OF YOUR REFERRER SOURCE]",
      "utm_content": "[USE THIS SPACE TO DIFFERENTIATE YOUR EMAIL FROM ADS]",
      "utm_medium": "[NAME OF YOUR MARKETING MEDIUM e.g. email]",
      "utm_name": "[NAME OF YOUR CAMPAIGN]",
      "utm_term": "[IDENTIFY PAID KEYWORDS HERE]"
    },
    "open_tracking": {
      "enable": true,
      "substitution_tag": "%opentrack"
    },
    "subscription_tracking": {
      "enable": true,
      "html": "If you would like to unsubscribe and stop receiving these emails <% clickhere %>.",
      "substitution_tag": "<%click here%>",
      "text": "If you would like to unsubscribe and stop receiveing these emails <% click here %>."
    }
  }
}')
        headers = JSON.parse('{"X-Mock": 202}')

        response = @sg.client.mail._("send").post(request_body: data, request_headers: headers)

        self.assert_equal('202', response.status_code)
    end

    def test_mail_settings_get
        params = JSON.parse('{"limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_address_whitelist_patch
        data = JSON.parse('{
  "enabled": true,
  "list": [
    "email1@example.com",
    "example.com"
  ]
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.address_whitelist.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_address_whitelist_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.address_whitelist.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_bcc_patch
        data = JSON.parse('{
  "email": "email@example.com",
  "enabled": false
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.bcc.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_bcc_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.bcc.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_bounce_purge_patch
        data = JSON.parse('{
  "enabled": true,
  "hard_bounces": 5,
  "soft_bounces": 5
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.bounce_purge.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_bounce_purge_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.bounce_purge.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_footer_patch
        data = JSON.parse('{
  "enabled": true,
  "html_content": "...",
  "plain_content": "..."
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.footer.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_footer_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.footer.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_forward_bounce_patch
        data = JSON.parse('{
  "email": "example@example.com",
  "enabled": true
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.forward_bounce.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_forward_bounce_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.forward_bounce.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_forward_spam_patch
        data = JSON.parse('{
  "email": "",
  "enabled": false
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.forward_spam.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_forward_spam_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.forward_spam.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_plain_content_patch
        data = JSON.parse('{
  "enabled": false
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.plain_content.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_plain_content_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.plain_content.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_spam_check_patch
        data = JSON.parse('{
  "enabled": true,
  "max_score": 5,
  "url": "url"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.spam_check.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_spam_check_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.spam_check.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_template_patch
        data = JSON.parse('{
  "enabled": true,
  "html_content": "<% body %>"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.template.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mail_settings_template_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mail_settings.template.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_mailbox_providers_stats_get
        params = JSON.parse('{"end_date": "2016-04-01", "mailbox_providers": "test_string", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.mailbox_providers.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_partner_settings_get
        params = JSON.parse('{"limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.partner_settings.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_partner_settings_new_relic_patch
        data = JSON.parse('{
  "enable_subuser_statistics": true,
  "enabled": true,
  "license_key": ""
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.partner_settings.new_relic.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_partner_settings_new_relic_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.partner_settings.new_relic.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_scopes_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.scopes.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_senders_post
        data = JSON.parse('{
  "address": "123 Elm St.",
  "address_2": "Apt. 456",
  "city": "Denver",
  "country": "United States",
  "from": {
    "email": "from@example.com",
    "name": "Example INC"
  },
  "nickname": "My Sender ID",
  "reply_to": {
    "email": "replyto@example.com",
    "name": "Example INC"
  },
  "state": "Colorado",
  "zip": "80202"
}')
        headers = JSON.parse('{"X-Mock": 201}')
        response = @sg.client.senders.post(request_body: data, request_headers: headers)
        self.assert_equal(response.status_code, "201")
    end

    def test_senders_get
        headers = JSON.parse('{"X-Mock": 200}')
        response = @sg.client.senders.get(request_headers: headers)
        self.assert_equal(response.status_code, "200")
    end

    def test_senders__sender_id__patch
        data = JSON.parse('{
  "address": "123 Elm St.",
  "address_2": "Apt. 456",
  "city": "Denver",
  "country": "United States",
  "from": {
    "email": "from@example.com",
    "name": "Example INC"
  },
  "nickname": "My Sender ID",
  "reply_to": {
    "email": "replyto@example.com",
    "name": "Example INC"
  },
  "state": "Colorado",
  "zip": "80202"
}')
        sender_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')
        response = @sg.client.senders._(sender_id).patch(request_body: data, request_headers: headers)
        self.assert_equal(response.status_code, "200")
    end

    def test_senders__sender_id__get
        sender_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')
        response = @sg.client.senders._(sender_id).get(request_headers: headers)
        self.assert_equal(response.status_code, "200")
    end

    def test_senders__sender_id__delete
        sender_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')
        response = @sg.client.senders._(sender_id).delete(request_headers: headers)
        self.assert_equal(response.status_code, "204")
    end

    def test_senders__sender_id__resend_verification_post
        sender_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')
        response = @sg.client.senders._(sender_id).resend_verification.post(request_headers: headers)
        self.assert_equal(response.status_code, "204")
    end

    def test_stats_get
        params = JSON.parse('{"aggregated_by": "day", "limit": 1, "start_date": "2016-01-01", "end_date": "2016-04-01", "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers_post
        data = JSON.parse('{
  "email": "John@example.com",
  "ips": [
    "1.1.1.1",
    "2.2.2.2"
  ],
  "password": "johns_password",
  "username": "John@example.com"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers_get
        params = JSON.parse('{"username": "test_string", "limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers_reputations_get
        params = JSON.parse('{"usernames": "test_string"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers.reputations.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers_stats_get
        params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "offset": 1, "start_date": "2016-01-01", "subusers": "test_string"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers_stats_monthly_get
        params = JSON.parse('{"subuser": "test_string", "limit": 1, "sort_by_metric": "test_string", "offset": 1, "date": "test_string", "sort_by_direction": "asc"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers.stats.monthly.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers_stats_sums_get
        params = JSON.parse('{"end_date": "2016-04-01", "aggregated_by": "day", "limit": 1, "sort_by_metric": "test_string", "offset": 1, "start_date": "2016-01-01", "sort_by_direction": "asc"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers.stats.sums.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers__subuser_name__patch
        data = JSON.parse('{
  "disabled": false
}')
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.subusers._(subuser_name).patch(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_subusers__subuser_name__delete
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.subusers._(subuser_name).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_subusers__subuser_name__ips_put
        data = JSON.parse('[
  "127.0.0.1"
]')
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers._(subuser_name).ips.put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers__subuser_name__monitor_put
        data = JSON.parse('{
  "email": "example@example.com",
  "frequency": 500
}')
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers._(subuser_name).monitor.put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers__subuser_name__monitor_post
        data = JSON.parse('{
  "email": "example@example.com",
  "frequency": 50000
}')
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers._(subuser_name).monitor.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers__subuser_name__monitor_get
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers._(subuser_name).monitor.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_subusers__subuser_name__monitor_delete
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.subusers._(subuser_name).monitor.delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_subusers__subuser_name__stats_monthly_get
        params = JSON.parse('{"date": "test_string", "sort_by_direction": "asc", "limit": 1, "sort_by_metric": "test_string", "offset": 1}')
        subuser_name = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.subusers._(subuser_name).stats.monthly.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_blocks_get
        params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.blocks.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_blocks_delete
        data = JSON.parse('{
  "delete_all": false,
  "emails": [
    "example1@example.com",
    "example2@example.com"
  ]
}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.blocks.delete(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_blocks__email__get
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.blocks._(email).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_blocks__email__delete
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.blocks._(email).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_bounces_get
        params = JSON.parse('{"start_time": 1, "end_time": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.bounces.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_bounces_delete
        data = JSON.parse('{
  "delete_all": true,
  "emails": [
    "example@example.com",
    "example2@example.com"
  ]
}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.bounces.delete(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_bounces__email__get
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.bounces._(email).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_bounces__email__delete
        params = JSON.parse('{"email_address": "example@example.com"}')
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.bounces._(email).delete(query_params: params, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_invalid_emails_get
        params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.invalid_emails.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_invalid_emails_delete
        data = JSON.parse('{
  "delete_all": false,
  "emails": [
    "example1@example.com",
    "example2@example.com"
  ]
}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.invalid_emails.delete(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_invalid_emails__email__get
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.invalid_emails._(email).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_invalid_emails__email__delete
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.invalid_emails._(email).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_spam_report__email__get
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.spam_reports._(email).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_spam_report__email__delete
        email = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.spam_reports._(email).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_spam_reports_get
        params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.spam_reports.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_suppression_spam_reports_delete
        data = JSON.parse('{
  "delete_all": false,
  "emails": [
    "example1@example.com",
    "example2@example.com"
  ]
}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.suppression.spam_reports.delete(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_suppression_unsubscribes_get
        params = JSON.parse('{"start_time": 1, "limit": 1, "end_time": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.suppression.unsubscribes.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_templates_post
        data = JSON.parse('{
  "name": "example_name"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.templates.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_templates_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.templates.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_templates__template_id__patch
        data = JSON.parse('{
  "name": "new_example_name"
}')
        template_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.templates._(template_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_templates__template_id__get
        template_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.templates._(template_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_templates__template_id__delete
        template_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.templates._(template_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_templates__template_id__versions_post
        data = JSON.parse('{
  "active": 1,
  "html_content": "<%body%>",
  "name": "example_version_name",
  "plain_content": "<%body%>",
  "subject": "<%subject%>",
  "template_id": "ddb96bbc-9b92-425e-8979-99464621b543"
}')
        template_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.templates._(template_id).versions.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_templates__template_id__versions__version_id__patch
        data = JSON.parse('{
  "active": 1,
  "html_content": "<%body%>",
  "name": "updated_example_name",
  "plain_content": "<%body%>",
  "subject": "<%subject%>"
}')
        template_id = "test_url_param"
        version_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.templates._(template_id).versions._(version_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_templates__template_id__versions__version_id__get
        template_id = "test_url_param"
        version_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.templates._(template_id).versions._(version_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_templates__template_id__versions__version_id__delete
        template_id = "test_url_param"
        version_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.templates._(template_id).versions._(version_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_templates__template_id__versions__version_id__activate_post
        template_id = "test_url_param"
        version_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.templates._(template_id).versions._(version_id).activate.post(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_get
        params = JSON.parse('{"limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_click_patch
        data = JSON.parse('{
  "enabled": true
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.click.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_click_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.click.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_google_analytics_patch
        data = JSON.parse('{
  "enabled": true,
  "utm_campaign": "website",
  "utm_content": "",
  "utm_medium": "email",
  "utm_source": "sendgrid.com",
  "utm_term": ""
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.google_analytics.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_google_analytics_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.google_analytics.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_open_patch
        data = JSON.parse('{
  "enabled": true
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.open.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_open_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.open.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_subscription_patch
        data = JSON.parse('{
  "enabled": true,
  "html_content": "html content",
  "landing": "landing page html",
  "plain_content": "text content",
  "replace": "replacement tag",
  "url": "url"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.subscription.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_tracking_settings_subscription_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.tracking_settings.subscription.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_account_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.account.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_credits_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.credits.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_email_put
        data = JSON.parse('{
  "email": "example@example.com"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.email.put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_email_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.email.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_password_put
        data = JSON.parse('{
  "new_password": "new_password",
  "old_password": "old_password"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.password.put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_profile_patch
        data = JSON.parse('{
  "city": "Orange",
  "first_name": "Example",
  "last_name": "User"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.profile.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_profile_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.profile.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_scheduled_sends_post
        data = JSON.parse('{
  "batch_id": "YOUR_BATCH_ID",
  "status": "pause"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.user.scheduled_sends.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_user_scheduled_sends_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.scheduled_sends.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_scheduled_sends__batch_id__patch
        data = JSON.parse('{
  "status": "pause"
}')
        batch_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.user.scheduled_sends._(batch_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_user_scheduled_sends__batch_id__get
        batch_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.scheduled_sends._(batch_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_scheduled_sends__batch_id__delete
        batch_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.user.scheduled_sends._(batch_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_user_settings_enforced_tls_patch
        data = JSON.parse('{
  "require_tls": true,
  "require_valid_cert": false
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.settings.enforced_tls.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_settings_enforced_tls_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.settings.enforced_tls.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_username_put
        data = JSON.parse('{
  "username": "test_username"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.username.put(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_username_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.username.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_webhooks_event_settings_patch
        data = JSON.parse('{
  "bounce": true,
  "click": true,
  "deferred": true,
  "delivered": true,
  "dropped": true,
  "enabled": true,
  "group_resubscribe": true,
  "group_unsubscribe": true,
  "open": true,
  "processed": true,
  "spam_report": true,
  "unsubscribe": true,
  "url": "url"
}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.webhooks.event.settings.patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_webhooks_event_settings_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.webhooks.event.settings.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_webhooks_event_test_post
        data = JSON.parse('{
  "url": "url"
}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.user.webhooks.event.test.post(request_body: data, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_user_webhooks_parse_settings_post
        data = JSON.parse('{
  "hostname": "myhostname.com",
  "send_raw": false,
  "spam_check": true,
  "url": "http://email.myhosthame.com"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.user.webhooks.parse.settings.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_user_webhooks_parse_settings_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.webhooks.parse.settings.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_webhooks_parse_settings__hostname__patch
        data = JSON.parse('{
  "send_raw": true,
  "spam_check": false,
  "url": "http://newdomain.com/parse"
}')
        hostname = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.webhooks.parse.settings._(hostname).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_webhooks_parse_settings__hostname__get
        hostname = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.webhooks.parse.settings._(hostname).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_user_webhooks_parse_settings__hostname__delete
        hostname = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.user.webhooks.parse.settings._(hostname).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_user_webhooks_parse_stats_get
        params = JSON.parse('{"aggregated_by": "day", "limit": "test_string", "start_date": "2016-01-01", "end_date": "2016-04-01", "offset": "test_string"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.user.webhooks.parse.stats.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains_post
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
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.whitelabel.domains.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_whitelabel_domains_get
        params = JSON.parse('{"username": "test_string", "domain": "test_string", "exclude_subusers": "true", "limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains_default_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains.default.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains_subuser_get
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains.subuser.get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains_subuser_delete
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.whitelabel.domains.subuser.delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_whitelabel_domains__domain_id__patch
        data = JSON.parse('{
  "custom_spf": true,
  "default": false
}')
        domain_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains._(domain_id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains__domain_id__get
        domain_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains._(domain_id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains__domain_id__delete
        domain_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.whitelabel.domains._(domain_id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_whitelabel_domains__domain_id__subuser_post
        data = JSON.parse('{
  "username": "jane@example.com"
}')
        domain_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.whitelabel.domains._(domain_id).subuser.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_whitelabel_domains__id__ips_post
        data = JSON.parse('{
  "ip": "192.168.0.1"
}')
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains._(id).ips.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains__id__ips__ip__delete
        id = "test_url_param"
        ip = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains._(id).ips._(ip).delete(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_domains__id__validate_post
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.domains._(id).validate.post(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_ips_post
        data = JSON.parse('{
  "domain": "example.com",
  "ip": "192.168.1.1",
  "subdomain": "email"
}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.whitelabel.ips.post(request_body: data, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_whitelabel_ips_get
        params = JSON.parse('{"ip": "test_string", "limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.ips.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_ips__id__get
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.ips._(id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_ips__id__delete
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.whitelabel.ips._(id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_whitelabel_ips__id__validate_post
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.ips._(id).validate.post(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links_post
        data = JSON.parse('{
  "default": true,
  "domain": "example.com",
  "subdomain": "mail"
}')
        params = JSON.parse('{"limit": 1, "offset": 1}')
        headers = JSON.parse('{"X-Mock": 201}')

        response = @sg.client.whitelabel.links.post(request_body: data, query_params: params, request_headers: headers)

        self.assert_equal('201', response.status_code)
    end

    def test_whitelabel_links_get
        params = JSON.parse('{"limit": 1}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links_default_get
        params = JSON.parse('{"domain": "test_string"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links.default.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links_subuser_get
        params = JSON.parse('{"username": "test_string"}')
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links.subuser.get(query_params: params, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links_subuser_delete
        params = JSON.parse('{"username": "test_string"}')
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.whitelabel.links.subuser.delete(query_params: params, request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_whitelabel_links__id__patch
        data = JSON.parse('{
  "default": true
}')
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links._(id).patch(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links__id__get
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links._(id).get(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links__id__delete
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 204}')

        response = @sg.client.whitelabel.links._(id).delete(request_headers: headers)

        self.assert_equal('204', response.status_code)
    end

    def test_whitelabel_links__id__validate_post
        id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links._(id).validate.post(request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_whitelabel_links__link_id__subuser_post
        data = JSON.parse('{
  "username": "jane@example.com"
}')
        link_id = "test_url_param"
        headers = JSON.parse('{"X-Mock": 200}')

        response = @sg.client.whitelabel.links._(link_id).subuser.post(request_body: data, request_headers: headers)

        self.assert_equal('200', response.status_code)
    end

    def test_license_file_year
        # Read the third line from the license file
        year = IO.readlines('./LICENSE.md')[2].gsub(/[^\d]/, '')
        self.assert_equal("#{Time.now.year}", year)
    end

    def test_env_sample_exists
        assert(File.file?('./.env_sample'))
    end

    def test_gitignore_exists
        assert(File.file?('./.gitignore'))
    end

    def test_travis_exists
        assert(File.file?('./.travis.yml'))
    end

    def test_codeclimate_exists
        assert(File.file?('./.codeclimate.yml'))
    end

    def test_changelog_exists
        assert(File.file?('./CHANGELOG.md'))
    end

    def test_code_of_conduct_exists
        assert(File.file?('./CODE_OF_CONDUCT.md'))
    end

    def test_contributing_exists
        assert(File.file?('./CONTRIBUTING.md'))
    end

    def test_issue_template_exists
        assert(File.file?('./ISSUE_TEMPLATE.md'))
    end

    def test_license_exists
        assert(File.file?('./LICENSE.md'))
    end

    def test_pr_template_exists
        assert(File.file?('./PULL_REQUEST_TEMPLATE.md'))
    end

    def test_readme_exists
        assert(File.file?('./README.md'))
    end

    def test_troubleshooting_exists
        assert(File.file?('./TROUBLESHOOTING.md'))
    end

    def test_usage_exists
        assert(File.file?('./USAGE.md'))
    end

    def test_use_cases_readme_exists
        assert(File.file?('./use-cases/README.md'))
    end
end

require_relative '../lib/sendgrid-ruby.rb'
require 'ruby_http_client'
require 'minitest/autorun'

class TestAPI < Minitest::Test
  def setup
  end

  def test_init
    headers = JSON.parse('
        {
            "X-Test": "test"
        }
    ')
    sg = SendGrid::API.new(api_key: "SENDGRID_API_KEY", host: "https://api.test.com", request_headers: headers, version: "v3")
    
    assert_equal("https://api.test.com", sg.host)
    test_headers = JSON.parse('
        {
            "Authorization": "Bearer SENDGRID_API_KEY",
            "Content-Type": "application/json",
            "X-Test": "test"
        }
    ')
    assert_equal(test_headers, sg.request_headers)
    assert_equal("v3", sg.version)
    assert_equal("2.0.0", sg.VERSION)
    assert_instance_of(SendGrid::Client, sg.client)
  end
end
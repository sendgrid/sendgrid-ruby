require_relative '../../../../lib/sendgrid/helpers/mail/email'
require 'minitest/autorun'

class TestEmail < Minitest::Test

  include SendGrid

  def test_split_email_full_email
    @email = Email.new(email: "Example User <test1@example.com>")
    expected_json = {
        "email"=>"test1@example.com",
        "name"=>"Example User"
    }
    assert_equal @email.to_json, expected_json
  end

  def test_split_email_only_email
    @email = Email.new(email: "test1@example.com")
    expected_json = {
        "email"=>"test1@example.com",
    }
    assert_equal @email.to_json, expected_json
  end

  def test_split_email_name_and_email
    @email = Email.new(name: "Example User", email: "test1@example.com")
    expected_json = {
        "email"=>"test1@example.com",
        "name"=>"Example User"
    }
    assert_equal @email.to_json, expected_json
  end

end
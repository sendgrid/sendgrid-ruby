require_relative '../../../../lib/sendgrid/helpers/mail/personalization'
require 'minitest/autorun'

class TestPersonalization < Minitest::Test

  include SendGrid

  def test_add_to
    @personalization = Personalization.new()
    @personalization.add_to(Email.new(email: 'test1@example.com', name: 'Example User'))
    expected_json = {
        "to"=>[
            {
                "email"=>"test1@example.com",
                "name"=>"Example User"
            }
        ]
    }
    @personalization.add_to(Email.new(email: 'test2@example.com', name: 'Example User 2'))
    expected_json = {
        "to"=>[
            {
                "email"=>"test1@example.com",
                "name"=>"Example User"
            },
            {
                "email"=>"test2@example.com",
                "name"=>"Example User 2"
            }
        ]
    }
    assert_equal @personalization.to_json, expected_json
  end

  def test_add_cc
    @personalization = Personalization.new()
    @personalization.add_cc(Email.new(email: 'test1@example.com', name: 'Example User'))
    expected_json = {
        "cc"=>[
            {
                "email"=>"test1@example.com",
                "name"=>"Example User"
            }
        ]
    }
    @personalization.add_cc(Email.new(email: 'test2@example.com', name: 'Example User 2'))
    expected_json = {
        "cc"=>[
            {
                "email"=>"test1@example.com",
                "name"=>"Example User"
            },
            {
                "email"=>"test2@example.com",
                "name"=>"Example User 2"
            }
        ]
    }
    assert_equal @personalization.to_json, expected_json
  end

  def test_add_bcc
    @personalization = Personalization.new()
    @personalization.add_bcc(Email.new(email: 'test1@example.com', name: 'Example User'))
    expected_json = {
        "bcc"=>[
            {
                "email"=>"test1@example.com",
                "name"=>"Example User"
            }
        ]
    }
    @personalization.add_bcc(Email.new(email: 'test2@example.com', name: 'Example User 2'))
    expected_json = {
        "bcc"=>[
            {
                "email"=>"test1@example.com",
                "name"=>"Example User"
            },
            {
                "email"=>"test2@example.com",
                "name"=>"Example User 2"
            }
        ]
    }
    assert_equal @personalization.to_json, expected_json
  end

  def test_add_header
    @personalization = Personalization.new()
    @personalization.add_header(Header.new(key: 'X-Test', value: 'True'))
    expected_json = {
        "headers"=>{
                "X-Test"=>"True"
            }
    }
    assert_equal @personalization.to_json, expected_json
    @personalization.add_header(Header.new(key: 'X-Test 1', value: 'False'))
    expected_json = {
        "headers"=>{
                "X-Test"=>"True",
                "X-Test 1"=>"False"
            }
    }
    assert_equal @personalization.to_json, expected_json
  end

  def test_add_substitution
    @personalization = Personalization.new()
    @personalization.add_substitution(Substitution.new(key: '%name%', value: 'Example User'))
    expected_json = {
        "substitutions"=>{
                "%name%"=>"Example User"
            }
    }
    assert_equal @personalization.to_json, expected_json
    @personalization.add_substitution(Substitution.new(key: '%name 1%', value: 'Example User 1'))
    expected_json = {
        "substitutions"=>{
                "%name%"=>"Example User",
                "%name 1%"=>"Example User 1"
            }
    }
    assert_equal @personalization.to_json, expected_json
  end

  def test_add_custom_arg
    @personalization = Personalization.new()
    @personalization.add_custom_arg(CustomArg.new(key: 'user_id', value: '343'))
    expected_json = {
        "custom_args"=>{
                "user_id"=>"343"
            }
    }
    assert_equal @personalization.to_json, expected_json
    @personalization.add_custom_arg(CustomArg.new(key: 'city', value: 'denver'))
    expected_json = {
        "custom_args"=>{
                "user_id"=>"343",
                "city"=>"denver"
            }
    }
    assert_equal @personalization.to_json, expected_json
  end

  def test_add_dynamic_template_data
    @personalization = Personalization.new()
    @personalization.add_dynamic_template_data({
        "name"=>"Example User",
        "city"=> "Denver"
    })
    expected_json = {
        "dynamic_template_data"=>{
                "name"=>"Example User",
                "city"=>"Denver"
            }
    }
    assert_equal @personalization.to_json, expected_json
  end

end
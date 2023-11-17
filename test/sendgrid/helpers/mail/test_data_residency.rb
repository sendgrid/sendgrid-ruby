require_relative '../../../../lib/sendgrid-ruby'
require 'minitest/autorun'

class TestDataResidency < Minitest::Test
  include SendGrid

  def setup
    @global_email = 'https://api.sendgrid.com'
    @eu_email = 'https://api.eu.sendgrid.com'
  end

  def test_with_global_data_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.data_residency('global')
    assert_equal @global_email, sg.host
  end

  def test_with_global_data_residency_in_constructor
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'global')
    assert_equal @global_email, sg.host
  end

  def test_with_global_eu_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.data_residency('eu')
    assert_equal @eu_email, sg.host
  end

  def test_with_global_eu_residency_in_constructor
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'eu')
    assert_equal @eu_email, sg.host
  end

  def test_with_host_set_first_and_residency_set_second
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'eu')
    sg.update_host("https://api.test.sendgrid.com")
    sg.data_residency("eu")
    assert_equal @eu_email, sg.host
  end

  def test_with_residency_set_first_and_host_set_second
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'eu')
    sg.data_residency("eu")
    sg.update_host("https://api.test.sendgrid.com")
    assert_equal "https://api.test.sendgrid.com", sg.host
  end

  def test_with_global_nil_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.data_residency(nil)
    end
  end

  def test_with_global_invalid_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.data_residency("abc")
    end
  end

  def test_with_global_empty_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.data_residency("")
    end
  end
end

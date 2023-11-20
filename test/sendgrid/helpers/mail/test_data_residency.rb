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
    sg.data_residency(region: 'global')
    assert_equal @global_email, sg.host
  end

  def test_with_global_data_residency_in_constructor
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'global')
    assert_equal @global_email, sg.host
  end

  def test_with_global_eu_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.data_residency(region: 'eu')
    assert_equal @eu_email, sg.host
  end

  def test_with_global_eu_residency_in_constructor
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'eu')
    assert_equal @eu_email, sg.host
  end

  def test_with_host_set_first_and_residency_set_second
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'eu')
    sg.update_host(host: "https://api.test.sendgrid.com")
    sg.data_residency(region: "eu")
    assert_equal @eu_email, sg.host
  end

  def test_with_residency_set_first_and_host_set_second
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], region: 'eu')
    sg.data_residency(region: "eu")
    sg.update_host(host: "https://api.test.sendgrid.com")
    assert_equal "https://api.test.sendgrid.com", sg.host
  end

  def test_with_global_nil_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.data_residency(region: nil)
    end
  end

  def test_with_global_invalid_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.data_residency(region: "abc")
    end
  end

  def test_with_global_empty_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.data_residency(region: "")
    end
  end

  def test_host_with_both_host_and_region_in_constructor
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'],host: "https://example.com",region: "eu")
    assert_equal @eu_email, sg.host
  end
end

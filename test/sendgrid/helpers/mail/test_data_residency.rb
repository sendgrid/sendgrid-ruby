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
    sg.sendgrid_data_residency(region: 'global')
    assert_equal @global_email, sg.host
  end

  def test_with_global_eu_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.sendgrid_data_residency(region: 'eu')
    assert_equal @eu_email, sg.host
  end

  def test_with_global_nil_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.sendgrid_data_residency(region: nil)
    end
  end

  def test_with_global_invalid_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.sendgrid_data_residency(region: "abc")
    end
  end

  def test_with_global_empty_residency
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    assert_raises(ArgumentError) do
      sg.sendgrid_data_residency(region: "")
    end
  end
end

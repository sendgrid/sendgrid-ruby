require 'spec_helper'

describe SendGrid::PartnerSettingsDto do
  let(:sendgrid_client) { SendGrid::API.new(api_key: 'fake_key').client }
  let(:partner_settings) { SendGrid::PartnerSettingsDto }
  let(:setting_name) { 'new_relic' }
  let(:setting_params) { {license_key: 'key', enabled: rand(1..100).even?} }

  it { should respond_to :new_relic }

  describe '.fetch' do
    it 'calls get on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, query_params: {} }
      expect(partner_settings.fetch(args)).to be_a SendGrid::Response
    end
  end

  describe '.update' do
    it 'calls patch on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, request_body: setting_params }
      expect(partner_settings.update(args)).to be_a SendGrid::Response
    end
  end
end

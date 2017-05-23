require 'spec_helper'

describe SendGrid::TrackingSettingsDto do
  let(:sendgrid_client) { SendGrid::API.new(api_key: 'fake_key').client }
  let(:tracking_settings) { SendGrid::TrackingSettingsDto }
  let(:setting_name) { 'open_tracking' }
  let(:setting_params) { {enabled: rand(1..100).even?} }

  it { should respond_to :open_tracking }
  it { should respond_to :click_tracking }
  it { should respond_to :google_analytics }
  it { should respond_to :subscription_tracking }

  describe '.fetch' do
    it 'calls get on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, query_params: {} }
      expect(tracking_settings.fetch(args)).to be_a SendGrid::Response
    end
  end

  describe '.update' do
    it 'calls patch on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, request_body: setting_params }
      expect(tracking_settings.update(args)).to be_a SendGrid::Response
    end
  end
end

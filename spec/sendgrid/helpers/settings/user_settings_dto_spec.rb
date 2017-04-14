require 'spec_helper'

describe SendGrid::UserSettingsDto do
  let(:sendgrid_client) { SendGrid::API.new(api_key: 'fake_key').client }
  let(:user_settings) { SendGrid::UserSettingsDto }
  let(:setting_name) { 'enforced_tls' }
  let(:setting_params) { {require_tls: rand(1..100).even?} }

  it { should respond_to :enforced_tls }

  describe '.fetch' do
    it 'calls get on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, query_params: {} }
      expect(user_settings.fetch(args)).to be_a SendGrid::Response
    end
  end

  describe '.update' do
    it 'calls patch on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, request_body: setting_params }
      expect(user_settings.update(args)).to be_a SendGrid::Response
    end
  end
end

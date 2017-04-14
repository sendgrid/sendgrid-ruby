require 'spec_helper'

describe SendGrid::MailSettingsDto do
  let(:sendgrid_client) { SendGrid::API.new(api_key: 'fake_key').client }
  let(:mail_settings) { SendGrid::MailSettingsDto }
  let(:setting_name) { 'bcc' }
  let(:setting_params) { {email: Faker::Internet.email, enabled: rand(1..100).even?} }

  it { should respond_to :bcc }
  it { should respond_to :address_whitelist }
  it { should respond_to :bounce_purge }
  it { should respond_to :footer }
  it { should respond_to :forward_spam }
  it { should respond_to :forward_bounce }
  it { should respond_to :plain_content }
  it { should respond_to :spam_check }
  it { should respond_to :template }

  describe '.fetch' do
    it 'calls get on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, query_params: {} }
      expect(mail_settings.fetch(args)).to be_a SendGrid::Response
    end
  end

  describe '.update' do
    it 'calls patch on sendgrid_client' do
      args = { sendgrid_client: sendgrid_client, name: setting_name, request_body: setting_params }
      expect(mail_settings.update(args)).to be_a SendGrid::Response
    end
  end
end

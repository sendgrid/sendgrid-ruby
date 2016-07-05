require 'spec_helper'

describe SendGrid::Settings do
  let(:sendgrid_client) { SendGrid::API.new(api_key: 'fake_key').client }
  let(:settings) { SendGrid::Settings.new(sendgrid_client: sendgrid_client) }

  describe '.new' do
    it 'initializes correctly' do
      expect(settings).to be_a SendGrid::Settings
    end
  end

  describe '.bcc' do
    it 'fetches bcc data' do
      expect(settings.bcc).to be_a SendGrid::Response
    end
  end

  describe '.update_bcc' do
    it 'updates bcc' do
      bcc_response = settings.update_bcc(enabled: true, email: "email@example.com")
      expect(bcc_response).to be_a SendGrid::Response
    end
  end
end
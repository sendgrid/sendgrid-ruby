require 'spec_helper'

describe SendGrid::API do
  describe '.new' do
    it 'initializes correctly' do
      mail_client = SendGrid::API.new(api_key: 'fake_key')
      expect(mail_client.request_headers['Authorization']).to eq('Bearer fake_key')
      expect(mail_client.host).to eq('https://api.sendgrid.com')
    end
  end
end

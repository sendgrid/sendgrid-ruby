require 'spec_helper'

describe TwilioEmail::API do
  describe '.new' do
    it 'initializes correctly' do
      mail_client = TwilioEmail::API.new(username: 'username', password: 'password')
      expect(mail_client.request_headers['Authorization']).to eq('Basic dXNlcm5hbWU6cGFzc3dvcmQ=')
      expect(mail_client.host).to eq('https://email.twilio.com')
    end
  end
end

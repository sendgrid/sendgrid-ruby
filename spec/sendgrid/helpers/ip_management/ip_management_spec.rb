require 'spec_helper'

describe SendGrid::IpManagement do
  let(:sendgrid_client) { SendGrid::API.new(api_key: 'fake_key').client }
  let(:ip_management) { SendGrid::IpManagement.new(sendgrid_client: sendgrid_client) }

  describe '.new' do
    it 'initializes correctly' do
      expect(ip_management).to be_a SendGrid::IpManagement
    end
  end
end

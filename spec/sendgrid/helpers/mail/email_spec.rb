require 'spec_helper'

describe SendGrid::Email do
  describe '::new' do
    let(:options) { { email: 'foo@bar.com' } }
    let(:email) { SendGrid::Email.new(**options) }

    it 'allows RFC822 emails' do
      expect(email).to be_a SendGrid::Email
    end

    it 'allows non RFC822 emails' do
      options.merge!(email: 'foo')

      expect(email).to be_a SendGrid::Email
      expect(email.email).to eq 'foo'
    end
  end
end
require 'spec_helper'
require './spec/fixtures/event_webhook'

describe SendGrid::EventWebhook do
  describe '.verify_signature' do
    it 'verifies a valid signature' do
      unless skip_jruby
        expect(verify(
          Fixtures::EventWebhook::PUBLIC_KEY,
          Fixtures::EventWebhook::PAYLOAD,
          Fixtures::EventWebhook::SIGNATURE,
          Fixtures::EventWebhook::TIMESTAMP
        )).to be true
      end
    end

    it 'rejects a bad key' do
      unless skip_jruby
        expect(verify(
          Fixtures::EventWebhook::FAILING_PUBLIC_KEY,
          Fixtures::EventWebhook::PAYLOAD,
          Fixtures::EventWebhook::SIGNATURE,
          Fixtures::EventWebhook::TIMESTAMP
        )).to be false
      end
    end

    it 'rejects a bad payload' do
      unless skip_jruby
        expect(verify(
          Fixtures::EventWebhook::PUBLIC_KEY,
          'payload',
          Fixtures::EventWebhook::SIGNATURE,
          Fixtures::EventWebhook::TIMESTAMP
        )).to be false
      end
    end

    it 'rejects a bad signature' do
      unless skip_jruby
        expect(verify(
          Fixtures::EventWebhook::PUBLIC_KEY,
          Fixtures::EventWebhook::PAYLOAD,
          Fixtures::EventWebhook::FAILING_SIGNATURE,
          Fixtures::EventWebhook::TIMESTAMP
        )).to be false
      end
    end

    it 'rejects a bad timestamp' do
      unless skip_jruby
        expect(verify(
          Fixtures::EventWebhook::PUBLIC_KEY,
          Fixtures::EventWebhook::PAYLOAD,
          Fixtures::EventWebhook::SIGNATURE,
          'timestamp'
        )).to be false
      end
    end

    it 'rejects a missing signature' do
      unless skip_jruby
        expect(verify(
          Fixtures::EventWebhook::PUBLIC_KEY,
          Fixtures::EventWebhook::PAYLOAD,
          nil,
          Fixtures::EventWebhook::TIMESTAMP
        )).to be false
      end
    end

    it 'throws an error when using jruby' do
      if skip_jruby
        expect{ verify(
          Fixtures::EventWebhook::PUBLIC_KEY,
          Fixtures::EventWebhook::PAYLOAD,
          Fixtures::EventWebhook::SIGNATURE, 
          Fixtures::EventWebhook::TIMESTAMP
        )}.to raise_error(SendGrid::EventWebhook::NotSupportedError)
      end
    end
  end
end

describe SendGrid::EventWebhookHeader do
  it 'sets the signature header constant' do
    expect(SendGrid::EventWebhookHeader::SIGNATURE).to eq("HTTP_X_TWILIO_EMAIL_EVENT_WEBHOOK_SIGNATURE")
  end

  it 'sets the timestamp header constant' do
    expect(SendGrid::EventWebhookHeader::TIMESTAMP).to eq("HTTP_X_TWILIO_EMAIL_EVENT_WEBHOOK_TIMESTAMP")
  end
end

def verify(public_key, payload, signature, timestamp)
  ew = SendGrid::EventWebhook.new
  ec_public_key = ew.convert_public_key_to_ecdsa(public_key)
  ew.verify_signature(ec_public_key, payload, signature, timestamp)
end

def skip_jruby
  RUBY_PLATFORM == 'java'
end

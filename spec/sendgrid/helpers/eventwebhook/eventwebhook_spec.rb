require "json"
require 'spec_helper'

describe SendGrid::EventWebhook do
  PUBLIC_KEY = 'MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDr2LjtURuePQzplybdC+u4CwrqDqBaWjcMMsTbhdbcwHBcepxo7yAQGhHPTnlvFYPAZFceEu/1FwCM/QmGUhA=='
  SIGNATURE = 'MEUCIQCtIHJeH93Y+qpYeWrySphQgpNGNr/U+UyUlBkU6n7RAwIgJTz2C+8a8xonZGi6BpSzoQsbVRamr2nlxFDWYNH2j/0='
  TIMESTAMP = '1588788367'
  PAYLOAD = {
      'category'=>'example_payload',
      'event'=>'test_event',
      'message_id'=>'message_id',
  }.to_json

  describe '.verify_signature' do
    it 'verifies a valid signature' do
      expect(verify(PUBLIC_KEY, PAYLOAD, SIGNATURE, TIMESTAMP)).to be
    end

    it 'rejects a bad key' do
      expect(verify(
                 'MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEqTxd43gyp8IOEto2LdIfjRQrIbsd4SXZkLW6jDutdhXSJCWHw8REntlo7aNDthvj+y7GjUuFDb/R1NGe1OPzpA==',
                 PAYLOAD,
                 SIGNATURE,
                 TIMESTAMP
             )).not_to be
    end

    it 'rejects a bad payload' do
      expect(verify(
                 PUBLIC_KEY,
                 'payload',
                 SIGNATURE,
                 TIMESTAMP
             )).not_to be
    end

    it 'rejects a bad signature' do
      expect(verify(
                 PUBLIC_KEY,
                 PAYLOAD,
                 'MEUCIQCtIHJeH93Y+qpYeWrySphQgpNGNr/U+UyUlBkU6n7RAwIgJTz2C+8a8xonZGi6BpSzoQsbVRamr2nlxFDWYNH3j/0=',
                 TIMESTAMP
             )).not_to be
    end

    it 'rejects a bad timestamp' do
      expect(verify(
                 PUBLIC_KEY,
                 PAYLOAD,
                 SIGNATURE,
                 'timestamp'
             )).not_to be
    end
  end
end

def verify(public_key, payload, signature, timestamp)
  ew = SendGrid::EventWebhook.new
  ec_public_key = ew.convert_public_key_to_ecdsa(public_key)
  ew.verify_signature(ec_public_key, payload, signature, timestamp)
end

require 'starkbank-ecdsa'

module SendGrid
  class EventWebhook
    def convert_public_key_to_ecdsa(public_key)
      verify_engine
      EllipticCurve::PublicKey.fromString(public_key)
    end

    def verify_signature(public_key, payload, signature, timestamp)
      verify_engine
      timestamped_playload = timestamp + payload
      decoded_signature = EllipticCurve::Signature.fromBase64(signature)

      EllipticCurve::Ecdsa.verify(timestamped_playload, decoded_signature, public_key)
    end

    def verify_engine
      # JRuby does not fully support ECDSA: https://github.com/jruby/jruby-openssl/issues/193
      if RUBY_PLATFORM == "java"
        raise NotSupportedError, "Event Webhook verfication is not supported by JRuby"
      end
    end

    class Error < ::RuntimeError
    end

    class NotSupportedError < Error
    end
  end
end

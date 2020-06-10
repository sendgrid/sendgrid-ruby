require 'starkbank-ecdsa'
module SendGrid
  # This class allows you to use the Event Webhook feature. Read the docs for
  # more details: https://sendgrid.com/docs/for-developers/tracking-events/event
  class EventWebhook
    # * *Args* :
    #   - +public_key+ -> verification key under Mail Settings
    #
    def convert_public_key_to_ecdsa(public_key)
      verify_engine
      EllipticCurve::PublicKey.fromString(public_key)
    end

    # * *Args* :
    #   - +public_key+ -> elliptic curve public key
    #   - +payload+ -> event payload in the request body
    #   - +signature+ -> signature value obtained from the 'X-Twilio-Email-Event-Webhook-Signature' header
    #   - +timestamp+ -> timestamp value obtained from the 'X-Twilio-Email-Event-Webhook-Timestamp' header
    def verify_signature(public_key, payload, signature, timestamp)
      verify_engine
      timestamped_playload = timestamp + payload
      decoded_signature = EllipticCurve::Signature.fromBase64(signature)

      EllipticCurve::Ecdsa.verify(timestamped_playload, decoded_signature, public_key)
    end

    def verify_engine
      # JRuby does not fully support ECDSA: https://github.com/jruby/jruby-openssl/issues/193
      if RUBY_PLATFORM == "java"
        raise NotSupportedError, "Event Webhook verification is not supported by JRuby"
      end
    end

    class Error < ::RuntimeError
    end

    class NotSupportedError < Error
    end
  end

  # This class lists headers that get posted to the webhook. Read the docs for
  # more details: https://sendgrid.com/docs/for-developers/tracking-events/event
  class EventWebhookHeader
    SIGNATURE = "HTTP_X_TWILIO_EMAIL_EVENT_WEBHOOK_SIGNATURE"
    TIMESTAMP = "HTTP_X_TWILIO_EMAIL_EVENT_WEBHOOK_TIMESTAMP"
  end
end

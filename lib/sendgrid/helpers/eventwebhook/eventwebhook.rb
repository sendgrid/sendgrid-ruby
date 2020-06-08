require 'starkbank-ecdsa'

module SendGrid
  class EventWebhook
    def convert_public_key_to_ecdsa(public_key)
      EllipticCurve::PublicKey.fromString(public_key)
    end

    def verify_signature(public_key, payload, signature, timestamp)
      timestamped_playload = timestamp + payload
      decoded_signature = EllipticCurve::Signature.fromBase64(signature)

      EllipticCurve::Ecdsa.verify(timestamped_playload, decoded_signature, public_key)
    end
  end
end

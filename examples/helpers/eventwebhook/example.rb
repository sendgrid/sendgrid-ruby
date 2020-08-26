require 'sengrid-ruby'
include SendGrid

def is_valid_signature(request)
  public_key = 'base64-encoded public key'

  event_webhook = SendGrid::EventWebhook.new
  ec_public_key = event_webhook.convert_public_key_to_ecdsa(public_key)

  event_webhook.verify_signature(
      ec_public_key,
      request.body.read,
      request.env[SendGrid::EventWebhookHeader::SIGNATURE],
      request.env[SendGrid::EventWebhookHeader::TIMESTAMP]
  )
end

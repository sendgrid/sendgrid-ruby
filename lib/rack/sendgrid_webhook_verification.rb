# frozen_string_literal: true

module Rack
  # Middleware that verifies webhooks from SendGrid using the EventWebhook
  # verifier.
  #
  # The middleware takes a public key with which to set up the request
  # validator and any number of paths. When a path matches the incoming request
  # path, the request will be verified using the signature and timestamp of the
  # request.
  #
  # Example:
  #
  # require 'rack'
  # use Rack::SendGridWebhookVerification, ENV['PUBLIC_KEY'], /\/emails/
  #
  # The above appends this middleware to the stack, using a public key saved in
  # the ENV and only against paths that match /\/emails/. If the request
  # validates then it gets passed on to the action as normal. If the request
  # doesn't validate then the middleware responds immediately with a 403 status.
  class SendGridWebhookVerification
    def initialize(app, public_key, *paths)
      @app = app
      @public_key = public_key
      @path_regex = Regexp.union(paths)
    end

    def call(env)
      return @app.call(env) unless env['PATH_INFO'].match(@path_regex)
      request = Rack::Request.new(env)

      event_webhook = SendGrid::EventWebhook.new
      ec_public_key = event_webhook.convert_public_key_to_ecdsa(@public_key)
      verified = event_webhook.verify_signature(
        ec_public_key,
        request.body.read,
        request.env[SendGrid::EventWebhookHeader::SIGNATURE],
        request.env[SendGrid::EventWebhookHeader::TIMESTAMP]
      )

      if verified
        return @app.call(env)
      else
        return [
          403,
          { 'Content-Type' => 'text/plain' },
          ['SendGrid Request Verification Failed.']
        ]
      end
    end
  end
end

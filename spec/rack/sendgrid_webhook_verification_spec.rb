require 'spec_helper'
require 'rack/mock'
require './spec/fixtures/event_webhook'

unless RUBY_PLATFORM == 'java'
  describe Rack::SendGridWebhookVerification do
    let(:public_key) { Fixtures::EventWebhook::PUBLIC_KEY }
    before do
      @app = ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['Hello']] }
    end

    describe 'new' do
      it 'should initialize with an app, public key and a path' do
        expect do
          Rack::SendGridWebhookVerification.new(@app, 'ABC', /\/email/)
        end.not_to raise_error
      end

      it 'should initialize with an app, public key and paths' do
        expect do
          Rack::SendGridWebhookVerification.new(@app, 'ABC', /\/email/, /\/event/)
        end.not_to raise_error
      end
    end

    describe 'calling against one path' do
      let(:middleware) { Rack::SendGridWebhookVerification.new(@app, public_key, /\/email/) }

      it "should not intercept when the path doesn't match" do
        expect(SendGrid::EventWebhook).to_not receive(:new)
        request = Rack::MockRequest.env_for('/login')
        status, headers, body = middleware.call(request)
        expect(status).to eq(200)
      end

      it 'should allow a request through if it is verified' do
        options = {
          :input => Fixtures::EventWebhook::PAYLOAD,
          'Content-Type' => "application/json"
        }
        options[SendGrid::EventWebhookHeader::SIGNATURE] = Fixtures::EventWebhook::SIGNATURE
        options[SendGrid::EventWebhookHeader::TIMESTAMP] = Fixtures::EventWebhook::TIMESTAMP
        request = Rack::MockRequest.env_for('/email', options)
        status, headers, body = middleware.call(request)
        expect(status).to eq(200)
      end

      it 'should short circuit a request to 403 if there is no signature or timestamp' do
        options = {
          :input => Fixtures::EventWebhook::PAYLOAD,
          'Content-Type' => "application/json"
        }
        request = Rack::MockRequest.env_for('/email', options)
        status, headers, body = middleware.call(request)
        expect(status).to eq(403)
      end

      it 'should short circuit a request to 403 if the signature is incorrect' do
        options = {
          :input => Fixtures::EventWebhook::PAYLOAD,
          'Content-Type' => "application/json"
        }
        options[SendGrid::EventWebhookHeader::SIGNATURE] = Fixtures::EventWebhook::FAILING_SIGNATURE
        options[SendGrid::EventWebhookHeader::TIMESTAMP] = Fixtures::EventWebhook::TIMESTAMP
        request = Rack::MockRequest.env_for('/email', options)
        status, headers, body = middleware.call(request)
        expect(status).to eq(403)
      end

      it 'should short circuit a request to 403 if the payload is incorrect' do
        options = {
          :input => 'payload',
          'Content-Type' => "application/json"
        }
        options[SendGrid::EventWebhookHeader::SIGNATURE] = Fixtures::EventWebhook::SIGNATURE
        options[SendGrid::EventWebhookHeader::TIMESTAMP] = Fixtures::EventWebhook::TIMESTAMP
        request = Rack::MockRequest.env_for('/email', options)
        status, headers, body = middleware.call(request)
        expect(status).to eq(403)
      end
    end

    describe 'calling with multiple paths' do
      let(:middleware) { Rack::SendGridWebhookVerification.new(@app, public_key, /\/email/, /\/events/) }

      it "should not intercept when the path doesn't match" do
        expect(SendGrid::EventWebhook).to_not receive(:new)
        request = Rack::MockRequest.env_for('/sms_events')
        status, headers, body = middleware.call(request)
        expect(status).to eq(200)
      end

      it 'should allow a request through if it is verified' do
        options = {
          :input => Fixtures::EventWebhook::PAYLOAD,
          'Content-Type' => "application/json"
        }
        options[SendGrid::EventWebhookHeader::SIGNATURE] = Fixtures::EventWebhook::SIGNATURE
        options[SendGrid::EventWebhookHeader::TIMESTAMP] = Fixtures::EventWebhook::TIMESTAMP
        request = Rack::MockRequest.env_for('/events', options)
        status, headers, body = middleware.call(request)
        expect(status).to eq(200)
      end

      it 'should short circuit a request to 403 if there is no signature or timestamp' do
        options = {
          :input => Fixtures::EventWebhook::PAYLOAD,
          'Content-Type' => "application/json"
        }
        request = Rack::MockRequest.env_for('/events', options)
        status, headers, body = middleware.call(request)
        expect(status).to eq(403)
      end
    end
  end
end

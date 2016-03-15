require 'faraday'

module SendGrid
  class Client
    attr_accessor :api_user, :api_key, :protocol, :host, :port, :url, :endpoint,
                  :user_agent, :template
    attr_writer :adapter, :conn, :raise_exceptions

    def initialize(params = {})
      self.api_user         = params.fetch(:api_user, nil)
      self.api_key          = params.fetch(:api_key, nil)
      self.protocol         = params.fetch(:protocol, 'https')
      self.host             = params.fetch(:host, 'api.sendgrid.com')
      self.port             = params.fetch(:port, nil)
      self.url              = params.fetch(:url, protocol + '://' + host + (port ? ":#{port}" : ''))
      self.endpoint         = params.fetch(:endpoint, '/api/mail.send.json')
      self.adapter          = params.fetch(:adapter, adapter)
      self.conn             = params.fetch(:conn, conn)
      self.user_agent       = params.fetch(:user_agent, "sendgrid/#{SendGrid::VERSION};ruby")
      self.raise_exceptions = params.fetch(:raise_exceptions, true)
      yield self if block_given?
    end

    def send(mail)
      handle_response do
        conn.post do |req|
          payload = mail.to_h
          req.url(endpoint)

          apply_v2_authorization(req, payload)
          req.body = payload
        end
      end
    end

  private

    def conn
      @conn ||= Faraday.new(url: url) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.adapter adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end

    def raise_exceptions?
      @raise_exceptions
    end

    def apply_v2_authorization(request, payload)
      # Check if using username + password or API key
      if api_user
        # Username + password
        payload.merge!(api_user: api_user, api_key: api_key)
      else
        # API key
        request.headers['Authorization'] = "Bearer #{api_key}"
      end
    end

    def handle_response(expected_status = 200)
      res = yield

      if raise_exceptions? && res.status != expected_status
        fail SendGrid::Exception, res.body
      end

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end
  end
end

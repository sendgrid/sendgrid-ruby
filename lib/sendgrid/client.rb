require 'faraday'
require 'base64'
require 'cgi'

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

    def bounces(options = {})
      handle_response do
        conn.get do |req|
          req.url('/v3/suppression/bounces')
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.params = options
        end
      end
    end

    def delete_bounce(email)
      handle_response(204) do
        conn.delete do |req|
          req.url("/v3/suppression/bounces/#{CGI.escape email}")
          apply_v3_authorization(req)
          apply_v3_headers(req)
        end
      end
    end

    private

    def conn
      @conn ||= Faraday.new(url: url) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.adapter adapter
        conn.headers['User-Agent'] = user_agent
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

    def apply_v3_authorization(request)
      if api_user
        value = Base64.encode64([api_user, api_key].join(':'))
        value.delete!("\n")
        value = "Basic #{value}"
      else
        value = "Bearer #{api_key}"
      end

      request.headers['Authorization'] = value
    end

    def apply_v3_headers(request)
      request.headers['Content-Type'] = 'application/json'
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

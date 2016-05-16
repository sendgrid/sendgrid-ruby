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
      post(endpoint, mail.to_h)
    end

    def get(path)
      request(:get, path)
    end

    def post(path, payload)
      request(:post, path, payload)
    end

    def request(method, path, payload={})
      res = conn.send(method) do |req|
        req.url(path)
        # Check if using username + password or API key
        if api_user
          # Username + password
          payload.merge!(api_user: api_user, api_key: api_key)
        else
          # API key
          req.headers['Authorization'] = "Bearer #{api_key}"
        end
        req.body = payload
      end
      fail SendGrid::Exception, res.body if raise_exceptions? && res.status != 200

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end

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
  end
end

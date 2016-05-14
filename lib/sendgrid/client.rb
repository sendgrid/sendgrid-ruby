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
      post endpoint, mail.to_h
    end

    def post(endpoint, payload = {})
      res = conn.post do |req|
        req.url endpoint

        if api_user
          # Username + password
          payload = payload.merge(api_user: api_user, api_key: api_key)
        else
          # API key
          req.headers['Authorization'] = "Bearer #{api_key}"
        end

        req.body = payload
      end

      raise SendGrid::Exception, res.body if raise_exceptions? && (res.status < 200 || res.status >= 300)

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end

    def patch(endpoint, payload = {})
      res = conn.patch do |req|
        req.url endpoint

        if api_user
          # Username + password
          payload = payload.merge(api_user: api_user, api_key: api_key)
        else
          # API key
          req.headers['Authorization'] = "Bearer #{api_key}"
        end

        req.body = payload
      end

      raise SendGrid::Exception, res.body if raise_exceptions? && (res.status < 200 || res.status >= 300)

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end

    def get(endpoint, payload = {})
      res = conn.get do |req|
        req.url endpoint

        if api_user
          # Username + password
          payload = payload.merge(api_user: api_user, api_key: api_key)
        else
          # API key
          req.headers['Authorization'] = "Bearer #{api_key}"
        end

        req.body = payload
      end

      raise SendGrid::Exception, res.body if raise_exceptions? && (res.status < 200 || res.status >= 300)

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end

    def delete(endpoint, payload = {})
      res = if api_user
        conn.basic_auth api_user, api_key
        conn.delete(endpoint)
      else
        conn.delete do |req|
          req.url endpoint
          # API key
          req.headers['Authorization'] = "Bearer #{api_key}"
        end
      end

      raise SendGrid::Exception, res.body if raise_exceptions? && (res.status < 200 || res.status >= 300)

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

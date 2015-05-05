require 'faraday'

module SendGrid
  class Client
    attr_accessor :api_user, :api_key, :protocol, :host, :port, :url, :endpoint, :user_agent
    attr_writer :adapter, :conn

    def initialize(params = {})
      self.api_user   = params.fetch(:api_user, nil)
      self.api_key    = params.fetch(:api_key, nil)
      self.protocol   = params.fetch(:protocol, 'https')
      self.host       = params.fetch(:host, 'api.sendgrid.com')
      self.port       = params.fetch(:port, nil)
      self.url        = params.fetch(:url, self.protocol + '://' + self.host + (self.port ? ":#{self.port}" : ''))
      self.endpoint   = params.fetch(:endpoint, '/api/mail.send.json')
      self.adapter    = params.fetch(:adapter, self.adapter)
      self.conn       = params.fetch(:conn, self.conn)
      self.user_agent = params.fetch(:user_agent, "sendgrid/#{SendGrid::VERSION};ruby")
      yield self if block_given?
    end

    def send(mail)
      res = self.conn.post do |req|
        payload = mail.to_h

        req.url(self.endpoint)

        # Check if using username + password or API key
        if self.api_user
          # Username + password
          payload.merge({api_user: self.api_user, api_key: self.api_key})
        else
          # API key
          req.headers['Authorization'] = "Bearer #{self.api_key}"
        end

        req.body = payload
      end
    end

    def conn
      @conn ||= Faraday.new(url: self.url) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.adapter self.adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end
  end
end

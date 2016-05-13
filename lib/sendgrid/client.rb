require 'faraday'

module SendGrid
  class Client
    attr_accessor :api_user, :api_key, :protocol, :host, :port, :url, :endpoint,
                  :user_agent, :template
    attr_writer :adapter, :conn, :raise_exceptions
    
    def self.client
      fail SendGrid::Exception, "Client not found. Please initialize a client." unless @client.is_a?(SendGrid::Client)
      @client
    end

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
      self.class.client     = self
      yield self if block_given?
    end

    def send(mail)
      res = conn.post do |req|
        payload = mail.to_h
        req.url(endpoint)

        # Check if using username + password or API key
        if api_user
          # Username + password
          payload = payload.merge(api_user: api_user, api_key: api_key)
        else
          # API key
          req.headers['Authorization'] = "Bearer #{api_key}"
        end

        req.body = payload
      end

      fail SendGrid::Exception, res.body if raise_exceptions? && res.status != 200

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end
    
    def post(url:, payload: {})
      res = conn.post do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end
      
      fail SendGrid::Exception, res.body if raise_exceptions? && res.status < 200 && res.status >= 300
      
      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end
    
    def patch(url:, payload: {})
      res = conn.patch do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end
      
      fail SendGrid::Exception, res.body if raise_exceptions? && res.status < 200 && res.status >= 300
      
      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end
    
    def get(url:)
      res = conn.get url
      
      fail SendGrid::Exception, res.body if raise_exceptions? && res.status < 200 && res.status >= 300
      
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
    
    def self.client=(client)
      client.conn.basic_auth(client.api_user, client.api_key)
      @client = client
    end
  end
end

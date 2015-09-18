=begin
# Testing with the old sending library
require_relative '../sendgrid/exceptions'
require_relative '../sendgrid/mail'
require_relative '../sendgrid/version'

require 'rest-client'

module SendGrid
  class Client
    attr_accessor :api_user, :api_key, :host, :endpoint

    def initialize(params = {})
      @api_user   = params.fetch(:api_user, nil)
      @api_key    = params.fetch(:api_key, nil)
      @host       = params.fetch(:host, 'https://api.sendgrid.com')
      @endpoint   = params.fetch(:endpoint, '/api/mail.send.json')
      @conn       = params.fetch(:conn, create_conn)
      @user_agent = params.fetch(:user_agent, 'sendgrid/' + SendGrid::VERSION + ';ruby')
      yield self if block_given?
      raise SendGrid::Exception.new('api_user and api_key are required') unless @api_user && @api_key
    end

    def send(mail)
      payload = mail.to_h.merge({api_user: @api_user, api_key: @api_key})
      @conn[@endpoint].post(payload, {user_agent: @user_agent}) do |response, request, result|
        case response.code.to_s
        when /2\d\d/
          response
        when /4\d\d|5\d\d/
          raise SendGrid::Exception.new(response)
        else
          # TODO: What will reach this?
          "DEFAULT #{response.code} #{response}"
        end
        puts "final old payload= " + payload.to_s
      end
    end

    private

    def create_conn
      @conn = RestClient::Resource.new(@host)
    end
  end
end
=end

require 'faraday'

module SendGrid
  class Client
    attr_accessor :api_user, :api_key, :protocol, :host, :port, :url, :endpoint,
                  :user_agent
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
        puts "final payload= " + req.body.to_s
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

require 'active_support/all'
require 'faraday'
require 'pry'

module MarketingCampaigns
  class Client
    attr_accessor :api_user, :api_key, :protocol, :host, :port, :url, :endpoint,
                  :user_agent, :template
    attr_writer :adapter, :conn, :raise_exceptions

    def initialize(params = {})
      self.api_key          = params.fetch(:api_key, nil)
      self.protocol         = params.fetch(:protocol, 'https')
      self.host             = params.fetch(:host, 'api.sendgrid.com')
      self.port             = params.fetch(:port, nil)
      self.url              = params.fetch(:url, protocol + '://' + host + (port ? ":#{port}" : ''))
      self.endpoint         = params.fetch(:endpoint, '/v3/campaigns')
      self.adapter          = params.fetch(:adapter, adapter)
      self.conn             = params.fetch(:conn, conn)
      self.user_agent       = params.fetch(:user_agent, "sendgrid/#{SendGrid::VERSION};ruby")
      yield self if block_given?
    end

    def create(campaign)
      res = conn.post do |req|
        payload = campaign.to_json
        build(req)
        req.url(endpoint)
        req.body = payload
      end
      output(res)
    end

    def get(id = '')
      res = conn.get do |req|
        build(req)
        if id.present?
          req.url(endpoint + '/' + id.to_s)
        else
          req.url(endpoint)
        end
      end
      output(res)
    end

    def delete(id)
      res = conn.delete do |req|
        build(req)
        req.url(endpoint + '/' + id.to_s)
      end
      output(res)
    end

    def conn
      @conn ||= Faraday.new(url: url) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.adapter adapter
      end
    end

    def build(request)
      request.headers['Authorization'] = "Bearer #{api_key}"
      # GZIP encoding issue
      # https://github.com/lostisland/faraday/issues/120
      request.headers['accept-encoding'] = "none"
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end

    def output(res)
      # marketing campaigns API returns multiple statuses, including failed with reasons
      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end

    def raise_exceptions?
      @raise_exceptions
    end
  end
end

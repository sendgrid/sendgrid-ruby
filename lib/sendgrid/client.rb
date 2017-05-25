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

    # Suppressions

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

    # Whitelabel Domains
    def whitelabel_domains(options = {})
      handle_response(200) do
        conn.get do |req|
          req.url("/v3/whitelabel/domains")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.params = options
        end
      end
    end


    def create_whitelabel_domain(options = {})
      handle_response(201) do
        conn.post do |req|
          req.url("/v3/whitelabel/domains")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.body = options.to_json
        end
      end
    end

    def validate_whitelabel_domain(id, options = {})
      handle_response(200) do
        conn.post do |req|
          req.url("/v3/whitelabel/domains/#{id}/validate")
          apply_v3_authorization(req)
          apply_v3_headers(req)
        end
      end
    end

    def delete_whitelabel_domain(id, options = {})
      handle_response(204) do
        conn.delete do |req|
          req.url("/v3/whitelabel/domains/#{id}")
          apply_v3_authorization(req)
          apply_v3_headers(req)
        end
      end
    end

    # API Keys

    def scopes(options = {})
      handle_response(200) do
        conn.get do |req|
          req.url("/v3/scopes")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.params = options
        end
      end
    end

    def api_keys(options = {})
      handle_response(200) do
        conn.get do |req|
          req.url("/v3/api_keys")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.params = options
        end
      end
    end

    def get_api_key(id)
      handle_response(200) do
        conn.get do |req|
          req.url("/v3/api_keys/#{id}")
          apply_v3_authorization(req)
          apply_v3_headers(req)
        end
      end
    end

    def create_api_key(options = {})
      handle_response(201) do
        conn.post do |req|
          req.url("/v3/api_keys")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.body = options.to_json
        end
      end
    end

    def update_api_key(id, options = {})
      handle_response(200) do
        conn.put do |req|
          req.url("/v3/api_keys/#{id}")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.body = options.to_json
        end
      end
    end

    # Subusers

    def create_subuser(options = {})
      handle_response(201) do
        conn.post do |req|
          req.url("/v3/subusers")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.body = options.to_json
        end
      end
    end

    # Apps (v2)

    def get_available_apps
      handle_response do
        conn.get do |req|
          payload = {}
          req.url("/api/filter.getavailable.json")

          apply_v2_authorization(req, payload)
          req.params = payload
        end
      end
    end

    def update_filter_settings(options = {})
      handle_response do
        conn.post do |req|
          payload = options
          req.url("/api/filter.setup.json")

          apply_v2_authorization(req, payload)
          req.body = payload
        end
      end
    end

    def activate_app(name)
      handle_response do
        conn.post do |req|
          payload = { name: name }
          req.url("/api/filter.activate.json")

          apply_v2_authorization(req, payload)
          req.body = payload
        end
      end
    end

    def deactivate_app(name)
      handle_response do
        conn.post do |req|
          payload = { name: name }
          req.url("/api/filter.deactivate.json")

          apply_v2_authorization(req, payload)
          req.body = payload
        end
      end
    end

    # Bounce Forwarding

    def get_forward_bounce_setting(options = {})
      handle_response do
        conn.get do |req|
          req.url("/v3/mail_settings/forward_bounce")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.params = options
        end
      end
    end

    def update_forward_bounce_setting(options = {})
      handle_response do
        conn.patch do |req|
          req.url("/v3/mail_settings/forward_bounce")
          apply_v3_authorization(req)
          apply_v3_headers(req)
          req.body = options.to_json
        end
      end
    end

    private

    def conn
      @conn ||= Faraday.new(url: url) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.adapter adapter
        conn.options.open_timeout = 120
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
        fail SendGrid::Exception, { code: res.status, headers: res.headers, body: res.body }.to_json
      end

      SendGrid::Response.new(code: res.status, headers: res.headers, body: res.body)
    end
  end
end

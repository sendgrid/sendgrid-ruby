require_relative 'sendgrid/version'
require_relative 'sendgrid/mail'
require_relative 'sendgrid/exceptions'

require 'rest-client'

module SendGrid
  class Client
    attr_reader :api_user, :api_key, :host, :endpoint

    def initialize(api_user, api_key, host = 'https://api.sendgrid.com', endpoint = '/api/mail.send.json', conn = nil)
      @api_user = api_user
      @api_key  = api_key
      @host     = host
      @endpoint = endpoint
      @conn     = conn || create_conn
    end

    def send(mail)
      payload = mail.to_h.merge({api_user: @api_user, api_key: @api_key})
      @conn[@endpoint].post(payload, {user_agent: 'sendgrid/' + SendGrid::VERSION + ';ruby'}) do |response, request, result|
        case response.code.to_s
        when /2\d\d/
          response
        when /4\d\d|5\d\d/
          raise SendGrid::Exception.new(response)
        else
          # TODO: What will reach this?
          "DEFAULT #{response.code} #{response}"
        end
      end
    end

    private

    def create_conn
      @conn = RestClient::Resource.new(@host)
    end
  end
end

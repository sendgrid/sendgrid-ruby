require_relative 'sendgrid/exceptions'
require_relative 'sendgrid/mail'
require_relative 'sendgrid/version'

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
      end
    end

    private

    def create_conn
      @conn = RestClient::Resource.new(@host)
    end
  end
end

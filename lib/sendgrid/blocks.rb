# params documentation: https://sendgrid.com/docs/API_Reference/Web_API/blocks.html

require_relative 'exceptions'
require_relative 'version'
require 'rest-client'
require 'json'

module SendGrid
  class Blocks
    attr_accessor :api_user,
                  :api_key,
                  :host,
                  :endpoint

    def initialize(params = {})
      @api_user   = params.fetch(:api_user, nil)
      @api_key    = params.fetch(:api_key, nil)
      @host       = params.fetch(:host, 'https://api.sendgrid.com')
      @endpoint   = params.fetch(:endpoint, '/api/blocks.get.json')
      @conn       = params.fetch(:conn, create_conn)
      @user_agent = params.fetch(:user_agent, 'sendgrid/' + SendGrid::VERSION + ';ruby')
      yield self if block_given?
      raise SendGrid::Exception.new('api_user and api_key are required') unless @api_user && @api_key
    end    

    def get(params = {})
      @endpoint   = '/api/blocks.get.json'
      send params
    end

    def delete(params = {})
      @endpoint   = '/api/blocks.delete.json'
      send params
    end

    def count(params = {})
      @endpoint   = '/api/blocks.count.json'
      send params
    end

    private

    def create_conn
      @conn = RestClient::Resource.new(@host)
    end

    def send(params = {})
      payload = {
        api_user: @api_user, 
        api_key: @api_key,
      }.merge(params).reject {|k,v| v.nil?}

      @conn[@endpoint].post(payload, {user_agent: @user_agent}) do |response, request, result|
        case response.code.to_s
        when /2\d\d/          
            JSON.load response
        when /4\d\d|5\d\d/
          raise SendGrid::Exception.new(response)
        else
          # TODO: What will reach this?
          "DEFAULT #{response.code} #{response}"
        end
      end
    end    
  end
end

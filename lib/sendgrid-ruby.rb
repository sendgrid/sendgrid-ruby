# Quickly and easily access the SendGrid API.
require 'ruby_http_client'

module SendGrid
  # Initialize the HTTP client
  class API
    attr_accessor :client
    attr_reader :VERSION, :request_headers, :host, :version
    # * *Args*    :
    #   - +api_key+ -> your SendGrid API key
    #   - +host+ -> the base URL for the API
    #   - +request_headers+ -> any headers that you want to be globally applied
    #   - +version+ -> the version of the API you wish to access,
    #                  currently only "v3" is supported
    #
    def initialize(api_key: nil, host: nil, request_headers: nil, version: nil)
      @VERSION = '2.0.0'
      @api_key          = api_key
      @host             = host ? host : 'https://api.sendgrid.com'
      @version          = version ? version : 'v3'
      @user_agent       = "sendgrid/#{@VERSION};ruby"
      @request_headers  = JSON.parse('
        {
          "Authorization": "Bearer ' + @api_key + '"
        }
      ')

      @request_headers = @request_headers.merge(request_headers) if request_headers
      @client = Client.new(host: "#{@host}/#{@version}",
                           request_headers: @request_headers)
    end
  end
end

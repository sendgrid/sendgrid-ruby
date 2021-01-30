require 'ruby_http_client'
require_relative 'version'

# Initialize the HTTP client
class BaseInterface
  attr_accessor :client
  attr_reader :request_headers, :host, :version, :impersonate_subuser, :http_options

  # * *Args* :
  #   - +auth+ -> authorization header value
  #   - +host+ -> the base URL for the API
  #   - +request_headers+ -> any headers that you want to be globally applied
  #   - +version+ -> the version of the API you wish to access,
  #                  currently only "v3" is supported
  #   - +impersonate_subuser+ -> the subuser to impersonate, will be passed
  #                              in the "On-Behalf-Of" header
  #   - +http_options+ -> http options that you want to be globally applied to each request
  #
  def initialize(auth:, host:, request_headers: nil, version: nil, impersonate_subuser: nil, http_options: {})
    @auth = auth
    @host = host
    @version = version || 'v3'
    @impersonate_subuser = impersonate_subuser
    @user_agent = "sendgrid/#{SendGrid::VERSION};ruby"
    @request_headers = JSON.parse('
        {
          "Authorization": "' + @auth + '",
          "Accept": "application/json",
          "User-Agent": "' + @user_agent + '"
        }
    ')
    @request_headers['On-Behalf-Of'] = @impersonate_subuser if @impersonate_subuser

    @request_headers = @request_headers.merge(request_headers) if request_headers
    @http_options = http_options
    @client = SendGrid::Client.new(host: "#{@host}/#{@version}",
                                   request_headers: @request_headers,
                                   http_options: @http_options)
  end
end

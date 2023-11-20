# Quickly and easily access the Twilio SendGrid API.
module SendGrid
  class API < BaseInterface
    # * *Args* :
    #   - +api_key+ -> your Twilio SendGrid API key
    #   - +host+ -> the base URL for the API
    #   - +request_headers+ -> any headers that you want to be globally applied
    #   - +version+ -> the version of the API you wish to access,
    #                  currently only "v3" is supported
    #   - +impersonate_subuser+ -> the subuser to impersonate, will be passed
    #                              in the "On-Behalf-Of" header
    #   - +http_options+ -> http options that you want to be globally applied to each request
    #   - +region+ -> data residency. The values only be either 'eu' or 'global'.
    #
    def initialize(api_key:, host: nil, region: nil, request_headers: nil, version: nil, impersonate_subuser: nil, http_options: {})
      auth = "Bearer #{api_key}"
      super(auth: auth, host: host, region: region, request_headers: request_headers, version: version, impersonate_subuser: impersonate_subuser, http_options: http_options)
    end
  end
end

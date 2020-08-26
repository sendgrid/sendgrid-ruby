# Quickly and easily access the Twilio Email API.
module TwilioEmail
  class API < BaseInterface
    # * *Args* :
    #   - +username+ -> your Twilio Email API key SID or Account SID
    #   - +password+ -> your Twilio Email API key secret or Account Auth Token
    #   - +host+ -> the base URL for the API
    #   - +request_headers+ -> any headers that you want to be globally applied
    #   - +version+ -> the version of the API you wish to access,
    #                  currently only "v3" is supported
    #   - +impersonate_subuser+ -> the subuser to impersonate, will be passed
    #                              in the "On-Behalf-Of" header
    #
    def initialize(username:, password:, host: nil, request_headers: nil, version: nil, impersonate_subuser: nil)
      auth = "Basic #{Base64.strict_encode64("#{username}:#{password}")}"
      host = 'https://email.twilio.com' unless host

      super(auth: auth, host: host, request_headers: request_headers, version: version, impersonate_subuser: impersonate_subuser)
    end
  end
end

require "faraday"

module SendGrid
  class Client

    def initialize(api_user, api_key)
      @api_user = api_user
      @api_key = api_key
      @host = "https://api.sendgrid.com"
    end

    attr_reader :api_user, :api_key, :host



    def send()

      # construct everything and faraday post.

    end  

  end
end
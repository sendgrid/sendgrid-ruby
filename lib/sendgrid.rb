require 'sendgrid/version'
require 'sendgrid/mail'
require 'faraday'

module SendGrid
  class Client

    def initialize(api_user, api_key)
      @api_user = api_user
      @api_key = api_key
      @host = "https://api.sendgrid.com"
    end

    attr_reader :api_user, :api_key, :host

    def send(mail)
      @conn ||= Faraday.new(@host)

      # payload = {
        # api_user: @api_user,
        # api_key: @api_key,
        # from: mail.from,
        # subject: mail.subject,
        # text: mail.text
      # }

      # mail.to.each do |to|
      # end

      @conn.post '/api/mail.send.json', { 
        api_user: @api_user,
        api_key: @api_key,
        to: mail.to[0][:email],
        from: mail.from,
        subject: mail.subject,
        text: mail.text
      }

    end  

  end
end

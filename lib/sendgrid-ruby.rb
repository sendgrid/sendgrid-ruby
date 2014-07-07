require 'sendgrid/version'
require 'sendgrid/mail'
require 'faraday'

module SendGrid
  class Client
    attr_reader :api_user, :api_key

    def initialize(api_user, api_key, conn = nil)
      @api_user = api_user
      @api_key  = api_key
      conn.nil? ? @conn = create_conn : @conn = conn
    end

    # TODO: Sort these better
    def send(mail)
      payload = {
        api_user: @api_user,
        api_key: @api_key,
        from: mail.from,
        fromname: (mail.from_name if mail.from_name),
        subject: mail.subject,
        to: [],
        toname: [],
        date: (mail.date if mail.date),
        replyto: (mail.reply_to if mail.reply_to),
        bcc: (mail.bcc if mail.bcc),
        text: (mail.text if mail.text),
        html: (mail.html if mail.html)
      }

      mail.to.each do |to|
        payload[:to] << to[:email]
        payload[:toname] << to[:name] if to[:name]
      end

      @conn.post '/api/mail.send.json', payload
    end

    private

    def create_conn
      @conn = Faraday.new(@host = 'https://api.sendgrid.com')
      @conn.headers[:user_agent] = 'sendgrid-ruby 0.0.1'
      @conn
    end
  end
end

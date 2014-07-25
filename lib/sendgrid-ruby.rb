require_relative 'sendgrid/version'
require_relative 'sendgrid/mail'

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

    # TODO: Sort these better
    def send(mail)
      payload = {
        :api_user    => @api_user,
        :api_key     => @api_key,
        :from        => mail.from,
        :fromname    => (mail.from_name if mail.from_name),
        :subject     => mail.subject,
        :to          => (mail.to if mail.to),
        :toname      => (mail.to_name if mail.to_name),
        :date        => (mail.date if mail.date),
        :replyto     => (mail.reply_to if mail.reply_to),
        :bcc         => (mail.bcc if mail.bcc),
        :text        => (mail.text if mail.text),
        :html        => (mail.html if mail.html),
        :'x-smtpapi' => (mail.smtpapi.to_json if mail.smtpapi),
        :files       => ({} unless mail.attachments.empty?)
      }

      # required if using smtpapi to
      if mail.to.nil? and not mail.smtpapi.to.empty?
        payload[:to] = payload[:from]
      end

      unless mail.attachments.empty?
        mail.attachments.each do |file|
          payload[:files][file[:name]] = file[:file]
        end
      end

      @conn[@endpoint].post(payload, {user_agent: 'sendgrid/' + SendGrid::VERSION + ';ruby'})
    end

    private

    def create_conn
      @conn = RestClient::Resource.new(@host)
    end
  end
end

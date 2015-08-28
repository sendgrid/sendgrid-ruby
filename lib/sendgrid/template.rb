require 'smtpapi'
require_relative './recipient'

module SendGrid
  class Template
    attr_reader :id, :recipients

    def initialize(id)
      @id = id
      @recipients = []
    end

    def add_recipient(recipient)
      recipients << recipient
    end

    def add_to_smtpapi(smtpapi)
      return if smtpapi.nil?

      smtpapi.tap do |api|
        api.add_filter(:template, :enabled, 1)
        api.add_filter(:template, :id, id)
        recipients.each { |r| r.add_to_smtpapi(smtpapi) }
      end
    end
  end
end

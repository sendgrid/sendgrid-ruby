require 'smtpapi'

module SendGrid
  class Template
    attr_reader :id, :recipients, :cache_recipients

    def initialize(id, opts = {})
      @id = id
      @recipients = []
      @cache_recipients = opts.fetch(:cache_recipients, true)
    end

    def add_recipient(recipient)
      @recipients = [] unless cache_recipients
      recipients << recipient
    end

    def add_to_smtpapi(smtpapi)
      return if smtpapi.nil?

      smtpapi.tap do |api|
        api.add_filter(:templates, :enable, 1)
        api.add_filter(:templates, :template_id, id)
        recipients.each { |r| r.add_to_smtpapi(smtpapi) }
      end
    end
  end
end

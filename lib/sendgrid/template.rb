require 'smtpapi'

module SendGrid
  class Template
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def add_to_smtpapi(smtpapi)
      return if smtpapi.nil?

      smtpapi.tap do |api|
        api.add_filter(:template, :enabled, 1)
        api.add_filter(:template, :id, id)
      end
    end
  end
end

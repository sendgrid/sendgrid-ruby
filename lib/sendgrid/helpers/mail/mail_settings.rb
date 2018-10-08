require 'json'

module SendGrid
  class MailSettings

    include SendGrid::Helpers

    attr_writer :sandbox_mode, :footer, :bcc, :spam_check, :bypass_list_management

    def initialize
      @bcc = nil
      @bypass_list_management = nil
      @footer = nil
      @sandbox_mode = nil
      @spam_check = nil
    end

    def sandbox_mode
      @sandbox_mode.to_json
    end

    def bypass_list_management
      @bypass_list_management.to_json
    end

    def footer
      @footer.to_json
    end

    def bcc
      @bcc.to_json
    end

    def spam_check
      @spam_check.to_json
    end
  end
end

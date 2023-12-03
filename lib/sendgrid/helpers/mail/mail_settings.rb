require 'json'

module SendGrid
  class MailSettings
    attr_writer :sandbox_mode, :footer, :bcc, :spam_check, :bypass_list_management, :bypass_spam_management, :bypass_bounce_management, :bypass_unsubscribe_management

    def initialize
      @bcc = nil
      @bypass_bounce_management = nil
      @bypass_list_management = nil
      @bypass_spam_management = nil
      @bypass_unsubscribe_management = nil
      @footer = nil
      @sandbox_mode = nil
      @spam_check = nil
    end

    def sandbox_mode
      @sandbox_mode.nil? ? nil : @sandbox_mode.to_json
    end

    def bypass_list_management
      @bypass_list_management.nil? ? nil : @bypass_list_management.to_json
    end

    def bypass_spam_management
      @bypass_spam_management.nil? ? nil : @bypass_spam_management.to_json
    end

    def bypass_bounce_management
      @bypass_bounce_management.nil? ? nil : @bypass_bounce_management.to_json
    end

    def bypass_unsubscribe_management
      @bypass_unsubscribe_management.nil? ? nil : @bypass_unsubscribe_management.to_json
    end

    def footer
      @footer.nil? ? nil : @footer.to_json
    end

    def bcc
      @bcc.nil? ? nil : @bcc.to_json
    end

    def spam_check
      @spam_check.nil? ? nil : @spam_check.to_json
    end

    def to_json(*)
      {
        'bcc' => bcc,
        'bypass_bounce_management' => bypass_bounce_management,
        'bypass_list_management' => bypass_list_management,
        'bypass_spam_management' => bypass_spam_management,
        'bypass_unsubscribe_management' => bypass_unsubscribe_management,
        'footer' => footer,
        'sandbox_mode' => sandbox_mode,
        'spam_check' => spam_check
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

module SendGrid
  class MailSettings
    def initialize
      @bcc = nil
      @bypass_list_management = nil
      @footer = nil
      @sandbox_mode = nil
      @spam_check = nil
    end

    def sandbox_mode=(sandbox_mode)
      @sandbox_mode = sandbox_mode
    end

    def sandbox_mode
      @sandbox_mode.nil? ? nil : @sandbox_mode.to_json
    end

    def bypass_list_management=(bypass_list_management)
      @bypass_list_management = bypass_list_management
    end

    def bypass_list_management
      @bypass_list_management.nil? ? nil : @bypass_list_management.to_json
    end

    def footer=(footer)
      @footer = footer
    end

    def footer
      @footer.nil? ? nil : @footer.to_json
    end

    def bcc=(bcc)
      @bcc = bcc
    end

    def bcc
      @bcc.nil? ? nil : @bcc.to_json
    end

    def spam_check=(spam_check)
      @spam_check = spam_check
    end

    def spam_check
      @spam_check.nil? ? nil : @spam_check.to_json
    end

    def to_json(*)
      {
        'bcc' => self.bcc,
        'bypass_list_management' => self.bypass_list_management,
        'footer' => self.footer,
        'sandbox_mode' => self.sandbox_mode,
        'spam_check' => self.spam_check
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

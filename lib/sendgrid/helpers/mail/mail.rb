# Build the request body for the v3/mail/send endpoint
# Please see the examples/helpers/mail/example.rb for a demonstration of usage
module SendGrid
  class Mail

    attr_accessor :subject, :ip_pool_name, :template_id, :send_at, :batch_id
    attr_reader :personalizations, :contents, :attachments, :categories, :sections, :headers, :custom_args

    def initialize(from_email=nil, subj=nil, to_email=nil, cont=nil)
      @from = nil
      @subject = nil
      @personalizations = []
      @contents = []
      @attachments = []
      @template_id = nil
      @sections = {}
      @headers = {}
      @categories = []
      @custom_args = {}
      @send_at = nil
      @batch_id = nil
      @asm = nil
      @ip_pool_name = nil
      @mail_settings = nil
      @tracking_settings = nil
      @reply_to = nil

      if !(from_email.nil? && subj.nil? && to_email.nil? && cont.nil?)
        self.from = from_email
        self.subject = subj
        personalization = Personalization.new
        personalization.add_to(to_email)
        self.add_personalization(personalization)
        self.add_content(cont)
      end
    end

    def from=(from)
      @from = from
    end

    def from
      @from.nil? ? nil : @from.to_json
    end

    def add_personalization(personalization)
      @personalizations << personalization.to_json
    end

    def add_content(content)
      @contents << content.to_json
    end

    def check_for_secrets(patterns)
      contents = @contents.map { |content| content['value'] }.join(' ')
      patterns.each do |pattern|
        raise SecurityError.new('Content contains sensitive information.') if contents.match(pattern)
      end
    end

    def add_attachment(attachment)
      @attachments << attachment.to_json
    end

    def add_category(category)
      @categories << category.name
    end

    def add_section(section)
      section = section.to_json
      @sections = @sections.merge(section['section'])
    end

    def add_header(header)
      header = header.to_json
      @headers = @headers.merge(header['header'])
    end

    def add_custom_arg(custom_arg)
      custom_arg = custom_arg.to_json
      @custom_args = @custom_args.merge(custom_arg['custom_arg'])
    end

    def asm=(asm)
      @asm = asm
    end

    def asm
      @asm.nil? ? nil : @asm.to_json
    end

    def mail_settings=(mail_settings)
      @mail_settings = mail_settings
    end

    def mail_settings
      @mail_settings.nil? ? nil : @mail_settings.to_json
    end

    def tracking_settings=(tracking_settings)
      @tracking_settings = tracking_settings
    end

    def tracking_settings
      @tracking_settings.nil? ? nil : @tracking_settings.to_json
    end

    def reply_to=(reply_to)
      @reply_to = reply_to
    end

    def reply_to
      @reply_to.nil? ? nil : @reply_to.to_json
    end

    def to_json(*)
      {
        'from' => self.from,
        'subject' => self.subject,
        'personalizations' => self.personalizations,
        'content' => self.contents,
        'attachments' => self.attachments,
        'template_id' => self.template_id,
        'sections' => self.sections,
        'headers' => self.headers,
        'categories' => self.categories,
        'custom_args' => self.custom_args,
        'send_at' => self.send_at,
        'batch_id' => self.batch_id,
        'asm' => self.asm,
        'ip_pool_name' => self.ip_pool_name,
        'mail_settings' => self.mail_settings,
        'tracking_settings' => self.tracking_settings,
        'reply_to' => self.reply_to
      }.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
    end
  end
end

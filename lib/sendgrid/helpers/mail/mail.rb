# Build the request body for the v3/mail/send endpoint
# Please see the examples/helpers/mail/example.rb for a demonstration of usage
require 'json'

module SendGrid
  class Mail
    attr_accessor :subject, :ip_pool_name, :template_id, :send_at, :batch_id
    attr_reader :personalizations, :contents, :attachments, :categories, :sections, :headers, :custom_args
    attr_writer :from, :asm, :mail_settings, :tracking_settings, :reply_to

    # We allow for all nil values here to create uninitialized Mail objects
    # (e.g. <project-root>/use-cases/transactional-templates.md)
    def initialize(from_email = nil, subj = nil, to_email = nil, cont = nil) # rubocop:disable Metrics/ParameterLists
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

      return if from_email.nil? && subj.nil? && to_email.nil? && cont.nil?

      self.from = from_email
      self.subject = subj
      personalization = Personalization.new
      personalization.add_to(to_email)
      add_personalization(personalization)
      add_content(cont)
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
        raise SecurityError, 'Content contains sensitive information.' if contents.match(pattern)
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

    def asm
      @asm.nil? ? nil : @asm.to_json
    end

    def mail_settings
      @mail_settings.nil? ? nil : @mail_settings.to_json
    end

    def tracking_settings
      @tracking_settings.nil? ? nil : @tracking_settings.to_json
    end

    def reply_to
      @reply_to.nil? ? nil : @reply_to.to_json
    end

    def to_json(*)
      {
        'from' => from,
        'subject' => subject,
        'personalizations' => personalizations,
        'content' => contents,
        'attachments' => attachments,
        'template_id' => template_id,
        'sections' => sections,
        'headers' => headers,
        'categories' => categories,
        'custom_args' => custom_args,
        'send_at' => send_at,
        'batch_id' => batch_id,
        'asm' => asm,
        'ip_pool_name' => ip_pool_name,
        'mail_settings' => mail_settings,
        'tracking_settings' => tracking_settings,
        'reply_to' => reply_to
      }.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {} }
    end
  end
end

# Build the request body for the v3/mail/send endpoint
# Please see the examples/helpers/mail/example.rb for a demonstration of usage
require 'json'

module SendGrid
  class Mail

    include SendGrid::Helpers

    attr_accessor :subject, :template_id, :send_at, :batch_id, :ip_pool_name
    attr_reader :personalizations, :contents, :attachments, :categories, :sections, :headers, :custom_args
    attr_writer :from, :asm, :mail_settings, :tracking_settings, :reply_to

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

    def from
      @from.to_json
    end

    def add_personalization(personalization)
      @personalizations << personalization.to_json
    end

    def add_content(content)
      @contents << content.to_json
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
      @asm.to_json
    end

    def mail_settings
      @mail_settings.to_json
    end

    def tracking_settings
      @tracking_settings.to_json
    end

    def reply_to
      @reply_to.to_json
    end

  end
end

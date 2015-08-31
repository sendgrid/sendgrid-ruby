require_relative './recipient'
require_relative './template'
require_relative './mail'

module SendGrid
  class InvalidClient < StandardError; end
  class InvalidTemplate < StandardError; end
  class InvalidRecipients < StandardError; end

  class TemplateMailer

    def initialize(client, template, recipients = [])
      @client = client
      @template = template
      @recipients = recipients

      raise InvalidClient, 'Client must be present' if @client.nil?
      raise InvalidTemplate, 'Template must be present' if @template.nil?
      raise InvalidRecipients, 'Recipients may not be empty' if @recipients.empty?

      @recipients.each do |recipient|
        @template.add_recipient(recipient)
      end
    end

    def mail(params = {})
      mail = Mail.new(params)

      mail.template = @template
      @client.send(mail.to_h)
    end
  end
end

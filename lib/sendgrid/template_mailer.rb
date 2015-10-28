module SendGrid
  class InvalidClient < StandardError; end
  class InvalidTemplate < StandardError; end
  class InvalidRecipients < StandardError; end

  class TemplateMailer

    # This class is responsible for coordinating the responsibilities
    #  of various models in the gem.
    # It makes use of the Recipient, Template and Mail models to create
    #  a single work flow, an example might look like:
    #
    # users = User.where(email: ['first@gmail.com', 'second@gmail.com'])
    #
    # recipients = []
    #
    # users.each do |user|
    #   recipient = SendGrid::Recipient.new(user.email)
    #   recipient.add_substitution('first_name', user.first_name)
    #   recipient.add_substitution('city', user.city)
    #
    #   recipients << recipient
    # end
    #
    # template = SendGrid::Template.new('MY_TEMPLATE_ID')
    #
    # client = SendGrid::Client.new(api_user: my_user, api_key: my_key)
    #
    # mail_defaults = {
    #   from: 'admin@email.com',
    #   html: '<h1>I like email</h1>',
    #   text: 'I like email',
    #   subject: 'Email is great',
    # }
    #
    # mailer = SendGrid::TemplateMailer.new(client, template, recipients)
    # mailer.mail(mail_defaults)
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

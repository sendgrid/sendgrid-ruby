module SendGrid
  class MailSettingsDto
    attr_reader :bcc, :address_whitelist, :bounce_purge, :footer, :forward_spam, :forward_bounce, :plain_content, :spam_check, :template

    def self.fetch(sendgrid_client:, name:, query_params:)
      sendgrid_client.mail_settings.public_send(name).get(query_params: query_params)
    end

    def self.update(sendgrid_client:, name:, request_body:)
      sendgrid_client.mail_settings.public_send(name).patch(request_body: request_body)
    end
  end
end

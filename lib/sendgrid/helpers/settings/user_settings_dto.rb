module SendGrid
  class UserSettingsDto
    attr_reader :enforced_tls

    def self.fetch(sendgrid_client:, name:, query_params:)
      sendgrid_client.user.settings.public_send(name).get(query_params: query_params)
    end

    def self.update(sendgrid_client:, name:, request_body:)
      sendgrid_client.user.settings.public_send(name).patch(request_body: request_body)
    end
  end
end

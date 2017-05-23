module SendGrid
  class PartnerSettingsDto
    attr_reader :new_relic

    def self.fetch(sendgrid_client:, name:, query_params:)
      sendgrid_client.partner_settings.public_send(name).get(query_params: query_params)
    end

    def self.update(sendgrid_client:, name:, request_body:)
      sendgrid_client.partner_settings.public_send(name).patch(request_body: request_body)
    end
  end
end

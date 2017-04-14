module SendGrid
  class TrackingSettingsDto
    attr_reader :open, :click, :google_analytics, :subscription
    alias :click_tracking :click
    alias :open_tracking :open
    alias :subscription_tracking :subscription

    def self.fetch(sendgrid_client:, name:, query_params:)
      name = scrub_alias_names(name.to_s)
      sendgrid_client.tracking_settings.public_send(name).get(query_params: query_params)
    end

    def self.update(sendgrid_client:, name:, request_body:)
      name = scrub_alias_names(name.to_s)
      sendgrid_client.tracking_settings.public_send(name).patch(request_body: request_body)
    end

    private

    def self.scrub_alias_names(name)
      name.gsub(/_tracking/, '')
    end
  end
end

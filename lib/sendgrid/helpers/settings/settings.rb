require_relative 'mail_settings'
require_relative 'partner_settings'
require_relative 'tracking_settings'
require_relative 'user_settings'

module SendGrid
  class Settings
    attr_accessor :sendgrid_client

    SETTING_TYPES = [SendGrid::MailSettings, SendGrid::TrackingSettings,
                     SendGrid::PartnerSettings, SendGrid::UserSettings]

    def initialize(sendgrid_client:)
      @sendgrid_client = sendgrid_client
    end

    SETTING_TYPES.each do |setting_type|
      setting_type.instance_methods(false).each do |name|
        define_method(name) do |**args|
          setting_type.fetch(sendgrid_client: sendgrid_client, name: name, query_params: args)
        end
        define_method("update_#{name}") do |**args|
          setting_type.update(sendgrid_client: sendgrid_client, name: name, request_body: args)
        end
      end
    end
  end
end

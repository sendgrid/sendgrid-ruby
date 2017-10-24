require 'json'

module SendGrid
  class IpManagement
    attr_accessor :sendgrid_client

    def initialize(sendgrid_client:)
      @sendgrid_client = sendgrid_client
    end

    def unassigned
      response = @sendgrid_client.ips.get
      ips = JSON.parse(response.body)
      ips.select {|ip| ip.subusers.empty?}
    end
  end
end

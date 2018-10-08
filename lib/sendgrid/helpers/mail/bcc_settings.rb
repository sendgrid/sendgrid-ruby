require 'json'

module SendGrid
  class BccSettings
    include SendGrid::Helpers

    attr_accessor :enable, :email

    def initialize(enable: nil, email: nil)
      @enable = enable
      @email = email
    end
  end
end

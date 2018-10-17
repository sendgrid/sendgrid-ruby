require 'json'

module SendGrid
  class BccSettings

    include SendGrid::Helpers

    def initialize(enable: nil, email: nil)
      @enable = enable
      @email = email
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def email=(email)
      @email = email
    end

    def email
      @email
    end

  end
end

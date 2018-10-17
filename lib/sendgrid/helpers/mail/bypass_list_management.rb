require 'json'

module SendGrid
  class BypassListManagement

    include SendGrid::Helpers

    def initialize(enable: nil)
      @enable = enable
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

  end

  class SandBoxMode

    include SendGrid::Helpers

    def initialize(enable: nil)
      @enable = enable
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

  end
end

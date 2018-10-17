require 'json'

module SendGrid
  class ClickTracking

    include SendGrid::Helpers

    def initialize(enable: nil, enable_text: nil)
      @enable = enable
      @enable_text = enable_text
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def enable_text=(enable_text)
      @enable_text = enable_text
    end

    def enable_text
      @enable_text
    end

  end
end

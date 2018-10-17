require 'json'

module SendGrid
  class Content

    include SendGrid::Helpers

    def initialize(type: nil, value: nil)
      @type = type
      @value = value
    end

    def type=(type)
      @type = type
    end

    def type
      @type
    end

    def value=(value)
      @value = value
    end

    def value
      @value
    end

  end
end

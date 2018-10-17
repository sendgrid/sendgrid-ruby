require 'json'

module SendGrid
  class OpenTracking
    def initialize(enable: nil, substitution_tag: nil)
      @enable = enable
      @substitution_tag = substitution_tag
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def substitution_tag=(substitution_tag)
      @substitution_tag = substitution_tag
    end

    def substitution_tag
      @substitution_tag
    end

    include SendGrid::Helpers
  end
end

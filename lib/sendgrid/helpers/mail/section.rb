require 'json'

module SendGrid
  class Section
    def initialize(key: nil, value: nil)
      @section = {}
      (key.nil? || value.nil?) ? @section = nil : @section[key] = value
    end

    def section=(section)
      @section = section
    end

    def section
      @section
    end

    include SendGrid::Helpers
  end
end

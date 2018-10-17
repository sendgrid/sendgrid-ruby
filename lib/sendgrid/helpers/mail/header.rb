require 'json'

module SendGrid
  class Header

    include SendGrid::Helpers

    def initialize(key: nil, value: nil)
      @header = {}
      (key.nil? || value.nil?) ? @header = nil : @header[key] = value
    end

    def header=(header)
      @header = header
    end

    def header
      @header
    end

  end
end

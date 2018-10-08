require 'json'

module SendGrid
  class Header

    include SendGrid::Helpers

    attr_accessor :header

    def initialize(key: nil, value: nil)
      @header = {}
      (key.nil? || value.nil?) ? @header = nil : @header[key] = value
    end
  end
end

require 'json'

module SendGrid
  class Section
    include SendGrid::Helpers

    attr_accessor :section

    def initialize(key: nil, value: nil)
      @section = {}
      key.nil? || value.nil? ? @section = nil : @section[key] = value
    end
  end
end

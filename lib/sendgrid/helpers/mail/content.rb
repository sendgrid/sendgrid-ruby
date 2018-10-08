require 'json'

module SendGrid
  class Content

    include SendGrid::Helpers

    attr_accessor :type, :value

    def initialize(type: nil, value: nil)
      @type = type
      @value = value
    end

  end
end

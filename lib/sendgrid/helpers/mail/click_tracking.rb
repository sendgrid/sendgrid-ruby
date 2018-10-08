require 'json'

module SendGrid
  class ClickTracking
    include SendGrid::Helpers

    attr_accessor :enable, :enable_text

    def initialize(enable: nil, enable_text: nil)
      @enable = enable
      @enable_text = enable_text
    end
  end
end

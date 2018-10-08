require 'json'

module SendGrid
  class Footer

    include SendGrid::Helpers

    attr_accessor :enable, :html, :text

    def initialize(enable: nil, text: nil, html: nil)
      @enable = enable
      @text = text
      @html = html
    end

  end
end

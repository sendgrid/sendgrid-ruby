require 'json'

module SendGrid
  class SubscriptionTracking

    include SendGrid::Helpers

    attr_accessor :enable, :text, :html, :substitution_tag

    def initialize(enable: nil, text: nil, html: nil, substitution_tag: nil)
      @enable = enable
      @text = text
      @html = html
      @substitution_tag = substitution_tag
    end

  end
end

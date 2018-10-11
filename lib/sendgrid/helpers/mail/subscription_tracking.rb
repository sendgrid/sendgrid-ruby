require 'json'

module SendGrid
  class SubscriptionTracking
    def initialize(enable: nil, text: nil, html: nil, substitution_tag: nil)
      @enable = enable
      @text = text
      @html = html
      @substitution_tag = substitution_tag
    end

    attr_writer :enable

    attr_reader :enable

    attr_writer :text

    attr_reader :text

    attr_writer :html

    attr_reader :html

    attr_writer :substitution_tag

    attr_reader :substitution_tag

    def to_json(*)
      {
        'enable' => enable,
        'text' => text,
        'html' => html,
        'substitution_tag' => substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

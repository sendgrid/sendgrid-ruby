require 'json'

module SendGrid
  class Footer
    def initialize(enable: nil, text: nil, html: nil)
      @enable = enable
      @text = text
      @html = html
    end

    attr_writer :enable

    attr_reader :enable

    attr_writer :text

    attr_reader :text

    attr_writer :html

    attr_reader :html

    def to_json(*)
      {
        'enable' => enable,
        'text' => text,
        'html' => html
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

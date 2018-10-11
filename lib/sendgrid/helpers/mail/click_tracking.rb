require 'json'

module SendGrid
  class ClickTracking
    def initialize(enable: nil, enable_text: nil)
      @enable = enable
      @enable_text = enable_text
    end

    attr_writer :enable

    attr_reader :enable

    attr_writer :enable_text

    attr_reader :enable_text

    def to_json(*)
      {
        'enable' => enable,
        'enable_text' => enable_text
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

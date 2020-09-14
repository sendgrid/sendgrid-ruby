require 'json'

module SendGrid
  class ClickTracking
    attr_accessor :enable, :enable_text

    def initialize(enable: nil, enable_text: nil)
      @enable = enable
      @enable_text = enable_text
    end

    def to_json(*)
      {
        'enable' => enable,
        'enable_text' => enable_text
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

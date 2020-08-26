module SendGrid
  class ClickTracking
    def initialize(enable: nil, enable_text: nil)
      @enable = enable
      @enable_text = enable_text
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def enable_text=(enable_text)
      @enable_text = enable_text
    end

    def enable_text
      @enable_text
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'enable_text' => self.enable_text
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

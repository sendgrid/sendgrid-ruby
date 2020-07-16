module SendGrid
  class SubscriptionTracking
    def initialize(enable: nil, text: nil, html: nil, substitution_tag: nil)
      @enable = enable
      @text = text
      @html = html
      @substitution_tag = substitution_tag
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def text=(text)
      @text = text
    end

    def text
      @text
    end

    def html=(html)
      @html = html
    end

    def html
      @html
    end

    def substitution_tag=(substitution_tag)
      @substitution_tag = substitution_tag
    end

    def substitution_tag
      @substitution_tag
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'text' => self.text,
        'html' => self.html,
        'substitution_tag' => self.substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

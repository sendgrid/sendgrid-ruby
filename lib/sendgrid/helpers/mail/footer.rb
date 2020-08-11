module SendGrid
  class Footer
    def initialize(enable: nil, text: nil, html: nil)
      @enable = enable
      @text = text
      @html = html
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

    def to_json(*)
      {
        'enable' => self.enable,
        'text' => self.text,
        'html' => self.html
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

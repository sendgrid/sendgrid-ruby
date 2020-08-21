module SendGrid
  class SpamCheck
    def initialize(enable: nil, threshold: nil, post_to_url: nil)
      @enable = enable
      @threshold = threshold
      @post_to_url = post_to_url
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def threshold=(threshold)
      @threshold = threshold
    end

    def threshold
      @threshold
    end

    def post_to_url=(post_to_url)
      @post_to_url = post_to_url
    end

    def post_to_url
      @post_to_url
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'threshold' => self.threshold,
        'post_to_url' => self.post_to_url
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

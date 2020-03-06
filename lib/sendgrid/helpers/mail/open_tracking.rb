module SendGrid
  class OpenTracking
    def initialize(enable: nil, substitution_tag: nil)
      @enable = enable
      @substitution_tag = substitution_tag
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
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
        'substitution_tag' => self.substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

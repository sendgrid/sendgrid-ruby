module SendGrid
  class OpenTracking
    attr_accessor :enable, :substitution_tag

    def initialize(enable: nil, substitution_tag: nil)
      @enable = enable
      @substitution_tag = substitution_tag
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'substitution_tag' => self.substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

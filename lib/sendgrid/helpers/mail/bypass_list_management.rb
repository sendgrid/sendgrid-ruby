module SendGrid
  class BypassListManagement
    def initialize(enable: nil)
      @enable = enable
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def to_json(*)
      {
        'enable' => self.enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class SandBoxMode
    def initialize(enable: nil)
      @enable = enable
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def to_json(*)
      {
        'enable' => self.enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

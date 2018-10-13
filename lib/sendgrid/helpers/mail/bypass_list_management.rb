require 'json'

module SendGrid
  # BypassListManagement
  class BypassListManagement
    attr_accessor :enable

    def initialize(enable: nil)
      @enable = enable
    end

    def to_json(*)
      {
        'enable' => enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  # SandBoxMode
  class SandBoxMode
    attr_accessor :enable

    def initialize(enable: nil)
      @enable = enable
    end

    def to_json(*)
      {
        'enable' => enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

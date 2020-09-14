require 'json'

module SendGrid
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

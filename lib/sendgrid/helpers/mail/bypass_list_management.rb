require 'json'

module SendGrid
  class BypassListManagement
    def initialize(enable: nil)
      @enable = enable
    end

    attr_writer :enable

    attr_reader :enable

    def to_json(*)
      {
        'enable' => enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class SandBoxMode
    def initialize(enable: nil)
      @enable = enable
    end

    attr_writer :enable

    attr_reader :enable

    def to_json(*)
      {
        'enable' => enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

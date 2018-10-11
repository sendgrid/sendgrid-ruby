require 'json'

module SendGrid
  class OpenTracking
    def initialize(enable: nil, substitution_tag: nil)
      @enable = enable
      @substitution_tag = substitution_tag
    end

    attr_writer :enable

    attr_reader :enable

    attr_writer :substitution_tag

    attr_reader :substitution_tag

    def to_json(*)
      {
        'enable' => enable,
        'substitution_tag' => substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

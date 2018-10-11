require 'json'

module SendGrid
  class Content
    def initialize(type: nil, value: nil)
      @type = type
      @value = value
    end

    attr_writer :type

    attr_reader :type

    attr_writer :value

    attr_reader :value

    def to_json(*)
      {
        'type' => type,
        'value' => value
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

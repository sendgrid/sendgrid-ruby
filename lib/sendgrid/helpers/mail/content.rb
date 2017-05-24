require 'json'

module SendGrid
  class Content
    def initialize(type: nil, value: nil)
      @type = type
      @value = value
    end

    def type=(type)
      @type = type
    end

    def type
      @type
    end

    def value=(value)
      @value = value
    end

    def value
      @value
    end

    def to_json(*)
      {
        'type' => self.type,
        'value' => self.value
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

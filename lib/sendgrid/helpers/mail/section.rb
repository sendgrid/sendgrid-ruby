require 'json'

module SendGrid
  class Section
    def initialize(key: nil, value: nil)
      @section = {}
      key.nil? || value.nil? ? @section = nil : @section[key] = value
    end

    attr_writer :section

    attr_reader :section

    def to_json(*)
      {
        'section' => section
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

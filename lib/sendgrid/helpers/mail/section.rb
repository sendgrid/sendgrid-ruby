require 'json'

module SendGrid
  class Section
    attr_accessor :section

    def initialize(key: nil, value: nil)
      @section = {}
      key.nil? || value.nil? ? @section = nil : @section[key] = value
    end

    def to_json(*)
      {
        'section' => section
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

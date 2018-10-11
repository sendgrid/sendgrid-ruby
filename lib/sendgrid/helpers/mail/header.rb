require 'json'

module SendGrid
  class Header
    def initialize(key: nil, value: nil)
      @header = {}
      key.nil? || value.nil? ? @header = nil : @header[key] = value
    end

    attr_writer :header

    attr_reader :header

    def to_json(*)
      {
        'header' => header
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

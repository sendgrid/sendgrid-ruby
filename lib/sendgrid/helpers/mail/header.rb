require 'json'

module SendGrid
  class Header
    attr_accessor :header

    def initialize(key: nil, value: nil)
      @header = {}
      key.nil? || value.nil? ? @header = nil : @header[key] = value
    end

    def to_json(*)
      {
        'header' => header
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

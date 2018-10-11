require 'json'

module SendGrid
  class Substitution
    def initialize(key: nil, value: nil)
      @substitution = {}
      key.nil? || value.nil? ? @substitution = nil : @substitution[key] = value
    end

    attr_writer :substitution

    attr_reader :substitution

    def to_json(*)
      {
        'substitution' => substitution
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

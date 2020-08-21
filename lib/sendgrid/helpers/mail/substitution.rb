module SendGrid
  class Substitution
    def initialize(key: nil, value: nil)
      @substitution = {}
      (key.nil? || value.nil?) ? @substitution = nil : @substitution[key] = value
    end

    def substitution=(substitution)
      @substitution = substitution
    end

    def substitution
      @substitution
    end

    def to_json(*)
      {
        'substitution' => self.substitution
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

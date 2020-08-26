module SendGrid
  class Section
    def initialize(key: nil, value: nil)
      @section = {}
      (key.nil? || value.nil?) ? @section = nil : @section[key] = value
    end

    def section=(section)
      @section = section
    end

    def section
      @section
    end

    def to_json(*)
      {
        'section' => self.section
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

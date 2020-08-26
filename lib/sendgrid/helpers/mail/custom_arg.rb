module SendGrid
  class CustomArg
    def initialize(key: nil, value: nil)
      @custom_arg = {}
      (key.nil? || value.nil?) ? @custom_arg = nil : @custom_arg[key.to_s] = value.to_s
    end

    def custom_arg=(custom_arg)
      @custom_arg = custom_arg
    end

    def custom_arg
      @custom_arg
    end

    def to_json(*)
      {
        'custom_arg' => self.custom_arg
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

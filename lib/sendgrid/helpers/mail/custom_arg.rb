require 'json'

module SendGrid
  class CustomArg

    include SendGrid::Helpers

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

  end
end

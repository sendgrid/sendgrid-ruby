require 'json'

module SendGrid
  class CustomArg
    include SendGrid::Helpers

    attr_accessor :custom_arg

    def initialize(key: nil, value: nil)
      @custom_arg = {}
      key.nil? || value.nil? ? @custom_arg = nil : @custom_arg[key.to_s] = value.to_s
    end
  end
end

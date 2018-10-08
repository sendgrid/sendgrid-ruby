require 'json'

module SendGrid
  class Substitution
    include SendGrid::Helpers

    attr_accessor :substitution

    def initialize(key: nil, value: nil)
      @substitution = {}
      key.nil? || value.nil? ? @substitution = nil : @substitution[key] = value
    end
  end
end

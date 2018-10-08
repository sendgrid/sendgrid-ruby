require 'json'

module SendGrid
  class OpenTracking
    include SendGrid::Helpers

    attr_accessor :enable, :substitution_tag

    def initialize(enable: nil, substitution_tag: nil)
      @enable = enable
      @substitution_tag = substitution_tag
    end
  end
end

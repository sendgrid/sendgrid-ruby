require 'json'

module SendGrid
  class BypassListManagement
    include SendGrid::Helpers

    attr_accessor :enable

    def initialize(enable: nil)
      @enable = enable
    end
  end

  class SandBoxMode < BypassListManagement; end
end

require 'smtpapi'

module SendGrid
  class Recipient
    class NoAddress < StandardError; end

    attr_reader :address, :substitutions

    def initialize(address)
      @address = address
      @substitutions = {}

      raise NoAddress, 'Recipient address cannot be nil' if @address.nil?
    end

    def add_substitution(key, value)
      substitutions[key] = value
    end

    def add_to_smtpapi(smtpapi)
      smtpapi.add_to(@address)

      @substitutions.each do |key, value|
        existing = smtpapi.sub[key] || []
        smtpapi.add_substitution(key, existing + [value])
      end
    end
  end
end

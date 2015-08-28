require 'smtpapi'

module SendGrid
  class Recipient

    attr_reader :address, :substitutions

    def initialize(address)
      @address = address
      @substitutions = {}
    end

    def add_substitution(key, value)
      substitutions[key.to_sym] = value
    end

    def add_to_smtpapi(smtpapi)
      return if @address.nil? || @substitutions.empty?
      smtpapi.add_to(@address)

      @substitutions.each do |key, value|
        smtpapi.add_substitution(key, value)
      end
    end
  end
end

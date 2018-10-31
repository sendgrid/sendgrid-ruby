module SendGrid
  class EmailAddressTypeError < TypeError
    def message
      "Email address must be a string"
    end
  end
end

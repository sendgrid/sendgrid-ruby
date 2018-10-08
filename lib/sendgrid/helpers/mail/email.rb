require 'json'

module SendGrid
  class Email
    include SendGrid::Helpers

    attr_accessor :email, :name

    def initialize(email: nil, name: nil)
      if name
        @email = email
        @name = name
      else
        @email, @name = split_email(email)
      end
    end

    def split_email(email)
      split = /(?:(?<address>.+)\s)?<?(?<email>.+@[^>]+)>?/.match(email)
      [split[:email], split[:address]]
    end
  end
end

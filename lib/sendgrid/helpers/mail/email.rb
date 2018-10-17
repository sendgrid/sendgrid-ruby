require 'pry'
require 'json'

module SendGrid
  class Email

    include SendGrid::Helpers

    def initialize(email: nil, name: nil)
      if name
        @email = email
        @name = name
      else
        @email, @name = split_email(email)
      end
    end

    def email=(email)
      @email = email
    end

    def email
      @email
    end

    def name=(name)
      @name = name
    end

    def name
      @name
    end

    def split_email(email)
      split = /(?:(?<address>.+)\s)?<?(?<email>.+@[^>]+)>?/.match(email)
      return split[:email], split[:address]
    end

  end
end

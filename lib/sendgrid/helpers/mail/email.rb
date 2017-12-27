require 'json'

module SendGrid
  class Email
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
      split ? [split[:email], split[:address]] : email
    end

    def to_json(*)
      {
        'email' => self.email,
        'name' => self.name
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

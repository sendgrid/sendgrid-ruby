module SendGrid
  class Email

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
      return split[:email], split[:address]
    end

    def to_json(*)
      {
        'email' => self.email,
        'name' => self.name
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

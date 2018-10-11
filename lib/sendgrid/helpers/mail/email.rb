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

    attr_writer :email

    attr_reader :email

    attr_writer :name

    attr_reader :name

    def split_email(email)
      split = /(?:(?<address>.+)\s)?<?(?<email>.+@[^>]+)>?/.match(email)
      [split[:email], split[:address]]
    end

    def to_json(*)
      {
        'email' => email,
        'name' => name
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

require 'json'

module SendGrid
  class Email
    def initialize(email: nil, name: nil)
      @email = email
      @name = name
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

    def to_json(*)
      {
        'email' => self.email,
        'name' => self.name
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

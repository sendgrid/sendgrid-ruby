require 'json'

module SendGrid
  class BccSettings
    def initialize(enable: nil, email: nil)
      @enable = enable
      @email = email
    end

    attr_writer :enable

    attr_reader :enable

    attr_writer :email

    attr_reader :email

    def to_json(*)
      {
        'enable' => enable,
        'email' => email
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

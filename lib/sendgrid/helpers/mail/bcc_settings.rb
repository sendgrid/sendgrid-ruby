module SendGrid
  class BccSettings
    attr_accessor :enable, :email

    def initialize(enable: nil, email: nil)
      @enable = enable
      @email = email
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'email' => self.email
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

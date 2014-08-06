require 'json'

module SendGrid
  class Exception < StandardError
    attr_reader :code, :errors, :message
    def initialize(message)
      res      = JSON.parse(message)
      @code    = message.code
      @message = res.message
      @errors  = res.errors
      super(message)
    end

    def to_s
      "Code: #{@code} Message: #{@message} Errors: #{errors}"
    end
  end
end

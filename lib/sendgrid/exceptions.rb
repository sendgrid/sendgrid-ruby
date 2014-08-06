module SendGrid
  class Exception < StandardError
    def initialize(message)
      super(message)
    end
  end
end

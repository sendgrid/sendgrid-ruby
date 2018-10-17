module SendGrid
  class BaseHelper
    private

    def sanitize(**data)
      data.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

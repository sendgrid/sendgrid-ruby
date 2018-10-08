module SendGrid
  module Helpers
    def as_json
      return nil if nil?

      # remove the setters
      keys = []
      (methods - Object.methods).each do |method|
        keys << method unless method.include?('=')
      end

      ret = {}
      keys.each do |method|
        val = send(method).strip
        ret[method.to_s] = val unless val.nil? || val.empty?
      end
      ret.to_json
    end
  end
end

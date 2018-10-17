module SendGrid
  module Helpers

    # this method name is not accurate.  This method returns a hash of the non-nil instance variables
    # TODO: update all uses to use :to_hash

    def to_json
      return nil if nil?

      ret = {}
      instance_variables.each do |attribute|
        val = instance_variable_get(attribute)
        val = val.strip if val.class == String
        next if val.class == String && val.empty?
        ret[attribute.to_s.tr('@', '')] = val unless val.nil?
      end

      ret
    end

    alias_method :to_hash, :to_json

  end
end

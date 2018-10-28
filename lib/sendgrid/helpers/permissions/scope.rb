# This is used for getting scopes
require 'yaml'

module SendGrid
  class Scope
    SCOPES = YAML.load_file(File.dirname(__FILE__) + '/scopes.yml').freeze
    
    class << self
      def admin_permissions
        SCOPES.values.map(&:values).flatten
      end

      def read_only_permissions
        SCOPES.map { |_, v| v[:read] }.flatten
      end

      SCOPES.each_key do |endpoint|
        define_method "#{endpoint}_read_only_permissions" do
          SCOPES[endpoint][:read]
        end

        define_method "#{endpoint}_full_access_permissions" do
          SCOPES[endpoint].values.flatten
        end
      end
    end
  end
end

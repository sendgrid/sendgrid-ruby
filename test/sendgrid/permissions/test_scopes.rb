require_relative '../../../lib/sendgrid/helpers/permissions/scope'
require 'minitest/autorun'

class TestCategory < Minitest::Test

  include SendGrid

  # usecases
  # 1. test admin scopes
  # 2. test read only scopes
  # 3. test read only and full access scopes for a method by hardcoding
  # 4. test read only and full access scopes by loading scopes.yaml

  def setup
    @scopes_from_yaml = YAML.load_file(File.dirname(__FILE__) + '/../../../lib/sendgrid/helpers/permissions/scopes.yml').freeze
  end

  def test_admin_scopes
    assert_equal Scope.admin_permissions, @scopes_from_yaml.values.map(&:values).flatten
  end

  def test_read_only_scopes
    assert_equal Scope.read_only_permissions, @scopes_from_yaml.map { |_, v| v[:read] }.flatten
  end

  def test_read_only_and_full_access_for_mail_hardcoded
    assert_equal Scope.mail_read_only_permissions, ["mail.batch.read"]
    assert_equal Scope.mail_full_access_permissions, ["mail.send", "mail.batch.create", "mail.batch.delete", "mail.batch.read", "mail.batch.update"]
  end

  def test_read_only_and_full_access_from_file
    @scopes_from_yaml.each_key do |endpoint|
      assert_equal Scope.send("#{endpoint}_read_only_permissions"), @scopes_from_yaml[endpoint][:read]
      assert_equal Scope.send("#{endpoint}_full_access_permissions"), @scopes_from_yaml[endpoint].values.flatten
    end
  end

end

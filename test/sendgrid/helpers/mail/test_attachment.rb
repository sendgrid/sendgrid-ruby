require_relative "../../../../lib/sendgrid/helpers/mail/attachment"
include SendGrid
require "json"
require "minitest/autorun"

class TestAttachment < Minitest::Test
  SAMPLE_INPUT = "Es blüht so grün wie Blüten blüh'n im Frühling
Es blüht so grün wie Blüten blüh'n im Frühling
Es blüht so grün wie Blüten blüh'n im Frühling
Es blüht so grün wie Blüten blüh'n im Frühling
Es blüht so grün wie Blüten blüh'n im Frühling
".force_encoding('UTF-8').encode

  def setup; end

  def test_io_enocding
    attachment = Attachment.new
    attachment.content = StringIO.new(SAMPLE_INPUT)

    expected = {
      "content" => "RXMgYmzDvGh0IHNvIGdyw7xuIHdpZSBCbMO8dGVuIGJsw7xoJ24gaW0gRnLDvGhsaW5nCkVzIGJsw7xodCBzbyBncsO8biB3aWUgQmzDvHRlbiBibMO8aCduIGltIEZyw7xobGluZwpFcyBibMO8aHQgc28gZ3LDvG4gd2llIEJsw7x0ZW4gYmzDvGgnbiBpbSBGcsO8aGxpbmcKRXMgYmzDvGh0IHNvIGdyw7xuIHdpZSBCbMO8dGVuIGJsw7xoJ24gaW0gRnLDvGhsaW5nCkVzIGJsw7xodCBzbyBncsO8biB3aWUgQmzDvHRlbiBibMO8aCduIGltIEZyw7xobGluZwo="
    }

    json = attachment.to_json

    # Double check that the decoded json matches original input.
    decoded = Base64.strict_decode64(json["content"]).force_encoding('UTF-8').encode

    assert_equal(decoded, SAMPLE_INPUT)

    assert_equal(json, expected)
  end
end

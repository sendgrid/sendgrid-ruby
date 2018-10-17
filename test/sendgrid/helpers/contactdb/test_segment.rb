
require_relative '../../../../lib/sendgrid/helpers/contactdb/segment'
require 'minitest/autorun'

class TestSegment < Minitest::Test
  def setup
    @described_class = SendGrid::Segment
  end

  def test_default_initialize_values
    segment = @described_class.new
    assert_nil segment.list_id
    assert_nil segment.name
    assert_equal segment.conditions, []
  end

  def test_data_constructing
    conditions = MiniTest::Mock.new
    conditions.expect :nil?, false
    conditions_data = MiniTest::Mock.new
    conditions.expect :map, conditions_data
    segment = @described_class.new(
      list_id: 1,
      name: 'Test segement',
      conditions: conditions
    )
    assert_equal segment.data, {
      list_id: 1,
      name: 'Test segement',
      conditions: conditions_data
    }
  end

  def test_data_constructing_omits_nil_value
    segment = @described_class.new(
      list_id: 1,
      name: nil,
      conditions: nil
    )
    assert_equal segment.data, { list_id: 1 }
  end
end

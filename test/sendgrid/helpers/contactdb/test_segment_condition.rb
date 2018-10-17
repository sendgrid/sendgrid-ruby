require_relative '../../../../lib/sendgrid/helpers/contactdb/segment_condition'
require 'minitest/autorun'

class TestSegmentCondition < Minitest::Test
  def setup
    @described_class = SendGrid::SegmentCondition
  end

  def test_operator_constants
    assert_equal @described_class::Operator::GT, 'gt'
    assert_equal @described_class::Operator::LT, 'lt'
    assert_equal @described_class::Operator::EQ, 'eq'
    assert_equal @described_class::Operator::NE, 'ne'
    assert_equal @described_class::Operator::CONTAINS, 'contains'
  end

  def test_and_or_constants
    assert_equal @described_class::AndOr::OR, 'or'
    assert_equal @described_class::AndOr::AND, 'and'
  end

  def test_data_constructing
    segment_condition = @described_class.new(
      and_or: @described_class::AndOr::AND,
      operator: nil,
      field: 'email',
      value: 'test@email.com'
    )
    assert_equal segment_condition.data, {
      and_or: 'and',
      field: 'email',
      value: 'test@email.com'
    }
  end

  def test_default_initialize_values
    segment_condition = @described_class.new
    assert_equal segment_condition.and_or, ''
    assert_nil segment_condition.operator
    assert_nil segment_condition.field
    assert_nil segment_condition.value
  end
end

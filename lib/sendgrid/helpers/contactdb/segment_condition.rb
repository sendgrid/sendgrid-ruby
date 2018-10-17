require_relative 'base_helper'

module SendGrid
  class SegmentCondition < BaseHelper
    module Operator
      EQ = 'eq'
      NE = 'ne'
      LT = 'lt'
      GT = 'gt'
      CONTAINS = 'contains'
    end

    module AndOr
      AND = 'and'
      OR = 'or'
    end

    attr_accessor :and_or, :field, :operator, :value

    def initialize(and_or: '', field: nil, operator: nil, value: nil)
      @and_or = and_or
      @field = field
      @operator = operator
      @value = value
    end

    def data
      sanitize(
        and_or: @and_or,
        field: @field,
        operator: @operator,
        value: @value
      )
    end
  end
end

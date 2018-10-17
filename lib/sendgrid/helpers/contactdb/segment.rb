require_relative 'base_helper'

module SendGrid
  class Segment < BaseHelper
    attr_accessor :list_id, :conditions, :name

    def initialize(list_id: nil, name: nil, conditions: [])
      @list_id = list_id
      @name = name
      @conditions = conditions
    end

    def data
      data = {
        list_id: @list_id,
        name: @name,
      }.tap do |memo|
        memo[:conditions] = @conditions.map(&:data) unless @conditions.nil?
      end
      sanitize(data)
    end
  end
end

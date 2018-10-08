require 'json'

module SendGrid
  class Category
    include SendGrid::Helpers

    attr_accessor :name

    def initialize(name: nil)
      @name = name
    end

    alias category name
    alias category= name=
  end
end

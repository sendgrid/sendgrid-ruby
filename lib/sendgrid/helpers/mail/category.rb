require 'json'

module SendGrid
  class Category
    attr_accessor :name

    def initialize(name: nil)
      @name = name
    end

    attr_writer :name

    attr_reader :name

    def to_json(*)
      {
        'category' => name
      }.delete_if { |_, value| value.to_s.strip == '' }
    end

    alias category name
    alias category= name=
  end
end

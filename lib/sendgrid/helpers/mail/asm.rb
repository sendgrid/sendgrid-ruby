require 'json'

module SendGrid
  class ASM
    include SendGrid::Helpers

    attr_accessor :group_id, :groups_to_display

    def initialize(group_id: nil, groups_to_display: nil)
      @group_id = group_id
      @groups_to_display = groups_to_display
    end
  end
end

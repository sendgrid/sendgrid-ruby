require 'json'

module SendGrid
  class ASM

    include SendGrid::Helpers

    def initialize(group_id: nil, groups_to_display: nil)
      @group_id = group_id
      @groups_to_display = groups_to_display
    end

    def group_id=(group_id)
      @group_id = group_id
    end

    def group_id
      @group_id
    end

    def groups_to_display=(groups_to_display)
      @groups_to_display = groups_to_display
    end

    def groups_to_display
      @groups_to_display
    end

  end
end

module SendGrid
  class ASM
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

    def to_json(*)
      {
        'group_id' => self.group_id,
        'groups_to_display' => self.groups_to_display
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

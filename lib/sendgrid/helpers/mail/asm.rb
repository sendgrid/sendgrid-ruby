require 'json'

module SendGrid
  class ASM
    attr_accessor :group_id, :groups_to_display

    def initialize(group_id: nil, groups_to_display: nil)
      @group_id = group_id
      @groups_to_display = groups_to_display
    end

    def to_json(*)
      {
        'group_id' => group_id,
        'groups_to_display' => groups_to_display
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

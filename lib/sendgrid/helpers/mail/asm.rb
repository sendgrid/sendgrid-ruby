require 'json'

module SendGrid
  class ASM
    def initialize(group_id: nil, groups_to_display: nil)
      @group_id = group_id
      @groups_to_display = groups_to_display
    end

    attr_writer :group_id

    attr_reader :group_id

    attr_writer :groups_to_display

    attr_reader :groups_to_display

    def to_json(*)
      {
        'group_id' => group_id,
        'groups_to_display' => groups_to_display
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

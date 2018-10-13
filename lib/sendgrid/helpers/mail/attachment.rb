require 'json'

module SendGrid
  # Attachment
  class Attachment
    attr_accessor :content,
                  :type,
                  :filename,
                  :disposition,
                  :content_id

    def initialize
      @content = nil
      @type = nil
      @filename = nil
      @disposition = nil
      @content_id = nil
    end

    def to_json(*)
      {
        'content' => content,
        'type' => type,
        'filename' => filename,
        'disposition' => disposition,
        'content_id' => content_id
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

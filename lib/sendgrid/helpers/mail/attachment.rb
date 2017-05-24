require 'json'

module SendGrid
  class Attachment
    def initialize
      @content = nil
      @type = nil
      @filename = nil
      @disposition = nil
      @content_id = nil
    end

    def content=(content)
      @content = content
    end

    def content
      @content
    end

    def type=(type)
      @type = type
    end

    def type
      @type
    end

    def filename=(filename)
      @filename = filename
    end

    def filename
      @filename
    end

    def disposition=(disposition)
      @disposition = disposition
    end

    def disposition
      @disposition
    end

    def content_id=(content_id)
      @content_id = content_id
    end

    def content_id
      @content_id
    end

    def to_json(*)
      {
        'content' => self.content,
        'type' => self.type,
        'filename' => self.filename,
        'disposition' => self.disposition,
        'content_id' => self.content_id
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

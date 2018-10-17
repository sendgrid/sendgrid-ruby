require 'json'

module SendGrid
  class Attachment

    include SendGrid::Helpers

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

  end
end

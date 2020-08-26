require 'base64'

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
      @encoded_content = nil
      @content = content
    end

    def content
      return @encoded_content if @encoded_content

      if @content.respond_to?(:read)
        @encoded_content = encode @content
      else
        @encoded_content = @content
      end
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

    private

    def encode(io)
      str = io.read
      # Since the API expects UTF-8, we need to ensure that we're
      # converting other formats to it so (byte-wise) Base64 encoding
      # will come through properly on the other side.
      #
      # Not much to be done to try to handle encoding for files opened
      # in binary mode, but at least we can faithfully convey the
      # bytes.
      str = str.encode('UTF-8') unless io.respond_to?(:binmode?) && io.binmode?
      Base64.encode64 str
    end
  end
end

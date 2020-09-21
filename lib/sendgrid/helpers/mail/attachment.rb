require 'base64'

module SendGrid
  class Attachment
    attr_accessor :type, :filename, :disposition, :content_id

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

      @encoded_content = if @content.respond_to?(:read)
                           encode @content
                         else
                           @content
                         end
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

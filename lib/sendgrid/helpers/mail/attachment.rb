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

    attr_writer :content

    attr_reader :content

    attr_writer :type

    attr_reader :type

    attr_writer :filename

    attr_reader :filename

    attr_writer :disposition

    attr_reader :disposition

    attr_writer :content_id

    attr_reader :content_id

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

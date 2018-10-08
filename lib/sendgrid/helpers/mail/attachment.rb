require 'json'

module SendGrid
  class Attachment
    include SendGrid::Helpers

    attr_accessor :content, :content_id, :disposition, :filename, :type

    def initialize
      @content = nil
      @type = nil
      @filename = nil
      @disposition = nil
      @content_id = nil
    end
  end
end

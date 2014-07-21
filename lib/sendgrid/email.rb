require 'json'
require 'smtpapi'

module SendGrid
  class Email
    attr_reader :bcc
    attr_accessor :to, :to_name, :from, :from_name, :subject, :text, :html, :bcc, :reply_to, :date, :smtpapi, :attachments

    def initialize(params = {})
      params.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @headers = @headers || {}
      @attachments = @attachments || []
      @smtpapi = @smtpapi || Smtpapi::Header.new
    end

    def add_to(to_email)
      @smtpapi.add_to to_email
    end

    def add_bcc(bcc_email)
      @bcc ||= []
      bcc_email.is_a?(Array) ? @bcc += bcc_email : @bcc << bcc_email
    end

    def add_attachment(path, name = nil)
      file = File.new(path)
      name = name || File.basename(file)
      @attachments << {name: name, file: file}
    end

    # TODO:
    def add_header(key, value)
      @headers[key] = value
    end

    # TODO:
    def set_x_smtpapi(key, value)
      @xsmtpapi[key] = value
    end
  end
end

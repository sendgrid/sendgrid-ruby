require 'json'
require 'smtpapi'

module SendGrid
  class Mail
    attr_reader :bcc
    attr_accessor :to, :to_name, :from, :from_name, :subject, :text, :html, :bcc, :reply_to, :date, :smtpapi, :attachments

    def initialize(params = {})
      params.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @headers ||= {}
      @attachments ||= []
      @smtpapi ||= Smtpapi::Header.new
    end

    # %w(from from_name).each do |method|
      # define_method "set#{method.capitalize}"
    # end

    def add_to(to_email)
      @smtpapi.add_to to_email
    end

    def add_bcc(bcc_email)
      @bcc ||= []
      bcc_email.is_a?(Array) ? @bcc += bcc_email : @bcc << bcc_email
    end

    def add_attachment(path, name = nil)
      file = File.new(path)
      name ||= File.basename(file)
      @attachments << {file: file, name: name}
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

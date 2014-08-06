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
      yield self if block_given?
    end

    # cross lib standard
    # %w(to to_name from from_name text html subject reply_to).each do |method|
      # define_method "set_#{method}" do |var|
        # instance_variable_set("@#{method}", var)
      # end
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

    def to_h
      payload = {
        :from        => @from,
        :fromname    => (@from_name if @from_name),
        :subject     => @subject,
        :to          => (@to if @to),
        :toname      => (@to_name if @to_name),
        :date        => (@date if @date),
        :replyto     => (@reply_to if @reply_to),
        :bcc         => (@bcc if @bcc),
        :text        => (@text if @text),
        :html        => (@html if @html),
        :'x-smtpapi' => (@smtpapi.to_json if @smtpapi),
        :files       => ({} unless @attachments.empty?)
      }

      # required if using smtpapi to
      if @to.nil? and not @smtpapi.to.empty?
        payload[:to] = payload[:from]
      end

      unless @attachments.empty?
        @attachments.each do |file|
          payload[:files][file[:name]] = file[:file]
        end
      end

      payload
    end
  end
end

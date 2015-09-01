require 'json'
require 'smtpapi'
require_relative './template'

module SendGrid
  class Mail

    PAYLOAD_PARAMS = %i[bcc cc date from from_name html reply_to subject text to to_name].freeze

    MAIL_PARAMS = (PAYLOAD_PARAMS + %i[attachments smtpapi headers template]).freeze

    attr_accessor *MAIL_PARAMS

    def initialize(params = {})
      MAIL_PARAMS.each do |mail_param|
        self.send("#{mail_param}=", params[mail_param]) unless params[mail_param].nil?
      end

      @headers     ||= {}
      @attachments ||= []
      @smtpapi     ||= Smtpapi::Header.new
      yield self if block_given?
    end

    def add_to(to_email)
      @smtpapi.add_to to_email
    end

    def add_attachment(path, name = nil)
      file   = File.new(path)
      name ||= File.basename(file)
      @attachments << {file: file, name: name}
    end

    def to_h
      payload = {}

      PAYLOAD_PARAMS.each do |payload_param|
        payload[payload_mapping(payload_param)] = self.send(payload_param)
      end

      payload.merge!({
        :'x-smtpapi' => smtpapi_json,
        :files       => extract_attachments(payload)
      })

      payload.reject! {|k,v| v.nil?}

      assign_missing_to(payload)

      payload
    end

    def payload_mapping(key)
      {
        from_name: :fromname,
        to_name: :toname,
        reply_to: :replyto,
      }[key] || key
    end

    def assign_missing_to(payload)
      # smtpapi fixer
      if @to.nil? and not @smtpapi.to.empty?
        payload[:to] = payload[:from]
      end
    end

    def extract_attachments(payload)
      return if @attachments.empty?

      {}.tap do |files|
        unless @attachments.empty?
          @attachments.each do |file|
            files[file[:name]] = file[:file]
          end
        end
      end
    end

    def smtpapi_json
      if !template.nil? && template.is_a?(Template)
        template.add_to_smtpapi(@smtpapi)
      end

      @smtpapi.to_json
    end
  end
end

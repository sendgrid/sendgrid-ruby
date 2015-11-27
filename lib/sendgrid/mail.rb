require 'json'
require 'smtpapi'
require 'mimemagic'

module SendGrid
  class Mail
    attr_accessor :to, :to_name, :from, :from_name, :subject, :text, :html, :cc, :cc_name,
                  :bcc, :bcc_name, :reply_to, :date, :smtpapi, :attachments, :content, :template

    def initialize(params = {})
      params.each do |k, v|
        send(:"#{k}=", v) unless v.nil?
      end

      yield self if block_given?
    end

    def add_to(email, name = nil)
      if email.is_a?(Array)
        to.concat(email)
      else
        to << email
      end
      add_to_name(name) if name
    end

    def to
      @to ||= []
    end

    def to_name
      @to_name ||= []
    end

    def add_to_name(name)
      if name.is_a?(Array)
        to_name.concat(name)
      else
        to_name << name
      end
    end

    def cc
      @cc ||= []
    end

    def cc_name
      @cc_name ||= []
    end

    def add_cc(email, name = nil)
      if email.is_a?(Array)
        cc.concat(email)
      else
        cc << email
      end
      add_cc_name(name) if name
    end

    def add_cc_name(name)
      if name.is_a?(Array)
        cc_name.concat(name)
      else
        cc_name << name
      end
    end

    def bcc
      @bcc ||= []
    end

    def bcc_name
      @bcc_name ||= []
    end

    def add_bcc(email, name = nil)
      if email.is_a?(Array)
        bcc.concat(email)
      else
        bcc << email
      end
      add_bcc_name(name) if name
    end

    def add_bcc_name(name)
      if name.is_a?(Array)
        bcc_name.concat(name)
      else
        bcc_name << name
      end
    end

    def add_attachment(path, name = nil)
      mime_type = MimeMagic.by_path(path)
      file = Faraday::UploadIO.new(path, mime_type)
      name ||= File.basename(file)
      attachments << {file: file, name: name}
    end

    def headers
      @headers ||= {}
    end

    def attachments
      @attachments ||= []
    end

    def contents
      @contents ||= []
    end

    def add_content(path, cid)
      mime_type = MimeMagic.by_path(path)
      file = Faraday::UploadIO.new(path, mime_type)
      name ||= File.basename(file)
      contents << {file: file, cid: cid, name: name}
    end

    def smtpapi
      @smtpapi ||= Smtpapi::Header.new
    end

    def smtpapi_json
      if !template.nil? && template.is_a?(Template)
        template.add_to_smtpapi(smtpapi)
      end

      smtpapi.to_json
    end

    # rubocop:disable Style/HashSyntax
    def to_h
      payload = {
        :from => from,
        :fromname => from_name,
        :subject => subject,
        :to => to,
        :toname => to_name,
        :date => date,
        :replyto => reply_to,
        :cc => cc,
        :ccname => cc_name,
        :bcc => bcc,
        :bccname => bcc_name,
        :text => text,
        :html => html,
        :'x-smtpapi' => smtpapi_json,
        :content => ({":default"=>"0"} unless contents.empty?),
        :files => ({":default"=>"0"} unless attachments.empty? and contents.empty?)
        # If I don't define a default value, I get a Nil error when
        # in attachments.each do |file|
        #:files => ({} unless attachments.empty?)
      }.reject {|_, v| v.nil? || v.empty?}

      payload.delete(:'x-smtpapi') if payload[:'x-smtpapi'] == '{}'

      payload[:to] = payload[:from] if payload[:to].nil? and not smtpapi.to.empty?

      unless attachments.empty?
        attachments.each do |file|
          payload[:files][file[:name]] = file[:file]
        end
        if payload[:files].has_key?(":default")
          payload[:files].delete(":default")
        end
      end

      unless contents.empty?
        contents.each do |content|
          payload[:content][content[:name]] = content[:cid]
          payload[:files][content[:name]] = content[:file]
        end
        if payload[:content].has_key?(":default")
          payload[:content].delete(":default")
        end
      end

      payload
    end
    # rubocop:enable Style/HashSyntax
  end
end

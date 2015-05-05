require 'json'
require 'smtpapi'

module SendGrid
  class Mail
    attr_accessor :to, :to_name, :from, :from_name, :subject, :text, :html, :cc, 
      :bcc, :reply_to, :date, :smtpapi, :attachments

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
      add_bcc_name(name)
    end

    def add_bcc_name(name)
      if name.is_a?(Array)
        bcc_name.concat(name)
      else
        bcc_name << name
      end
    end

    def add_attachment(path, name = nil)
      file   = File.new(path)
      name ||= File.basename(file)
      @attachments << {file: file, name: name}
    end

    def headers
      @headers ||= {}
    end

    def attachments
      @attachments ||= []
    end

    def smtpapi
      @smtpapi ||= Smtpapi::Header.new
    end

    def to_h
      payload = {
        :from        => from,
        :fromname    => from_name,
        :subject     => subject,
        :to          => to,
        :toname      => to_name,
        :date        => date,
        :replyto     => reply_to,
        :cc          => cc,
        :bcc         => bcc,
        :text        => text,
        :html        => html,
        :'x-smtpapi' => smtpapi.to_json,
        :files       => ({} unless attachments.empty?)
      }.reject {|k,v| v.nil?}

      # smtpapi bandaid
      if to.nil? && !smtpapi.to.empty?
        payload[:to] = payload[:from]
      end

      payload[:to] = payload[:from] if no_adressee?

      return if  @attachments.empty?
      @attachments.each do |file|
        payload[:files][file[:name]] = file[:file]
      end
      payload
    end


    private 
    def smtpapi_bandaid

    end
  end
end

require 'json'
require 'smtpapi'

module SendGrid
  class Mail
    attr_accessor :to, :to_name, :from, :from_name, :subject, :text, :html, :cc,
    :bcc, :reply_to, :date, :smtpapi, :attachments, :content

    def initialize(params = {})
      params.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @headers     ||= {}
      @contents    ||= []
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

    def add_content(path, cid)
      file = File.new(path)
      name = File.basename(file)
      @contents << {file: file, cid: cid, name: name}
    end

    def to_h
      payload = {
        :from        => @from,
        :fromname    => @from_name,
        :subject     => @subject,
        :to          => @to,
        :toname      => @to_name,
        :date        => @date,
        :replyto     => @reply_to,
        :cc          => @cc,
        :bcc         => @bcc,
        :text        => @text,
        :html        => @html,
        :'x-smtpapi' => @smtpapi.to_json,
        :content     => ({} unless @contents.empty?),
        :files       => ({} unless (@attachments.empty? and @contents.empty?))
      }.reject {|k,v| v.nil?}

      # smtpapi fixer
      if @to.nil? and not @smtpapi.to.empty?
        payload[:to] = payload[:from]
      end

      unless @attachments.empty?
        @attachments.each do |file|
          payload[:files][file[:name]] = file[:file]
        end
      end

      unless @contents.empty?
        @contents.each do |content|
          payload[:content][content[:name]] = content[:cid]
          payload[:files][content[:name]] = content[:file]
        end
      end

      payload
    end
  end
end

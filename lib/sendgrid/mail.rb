require 'json'
require 'smtpapi'

module SendGrid
  class Mail
    attr_reader :to, :bcc
    attr_accessor :from, :from_name, :subject, :text, :html, :bcc, :reply_to, :date, :smtpapi

    def initialize(params = {})
      @endpoint = '/api/mail.send.json'
      @headers = {}
      @attachments = []
      @to = []
    end

    def add_to(to_email, name = [])
      if to_email.is_a?(Array)
        to_email.each_with_index do |email, index|
          obj = { email: email }
          obj[:name] = name[index] unless name[index].nil?
          @to << obj
        end
      else
        @to << { email: to_email }
        @to.last[:name] = name if name
      end
    end

    def add_bcc(bcc_email)
      @bcc ||= []
      bcc_email.is_a?(Array) ? @bcc += bcc_email : @bcc << bcc_email
    end

    # TODO:
    def add_files(file)
      @attachments.push(get_file_info(file))
    end

    # TODO:
    def get_file_info(file)
      dir, basename = File.split(file)
      extname = File.extname(file)
      filename = File.basename(file, extname)
      info = {
        'dirname' => dir,
        'basename' => basename,
        'extension' => extname,
        'filename' => filename
      }
      info['file'] = file
      info
    end

    # TODO:
    def add_headers(key, value)
      @headers ||= {}
      @headers[key] = value
    end

    # TODO:
    def set_x_smtpapi(key, value)
      @xsmtpapi ||= {}
      @xsmtpapi[key] = value
    end
  end
end

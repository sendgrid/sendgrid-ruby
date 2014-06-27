require 'json'
require 'smtpapi'

module SendGrid
  class Mail

    attr_accessor :endpoint, :to, :from, :from_name, :subject, :text, :html, :bcc, :reply_to, :date, :smtpapi

    def initialize(params = {})
      @endpoint = "/api/mail.send.json"
      @headers = Hash.new
      @attachments = []
    end

    def add_to(to_email, name=[])
      @to ||= Array.new

      if to_email.is_a?(Array)

        to_email.each_with_index do |email, index|
          obj = {email: email}
          obj[:name] = name[index] unless name[index].nil?
          @to << obj
        end
      else
        @to << {email: to_email}
        @to.last[:name] = name if name
      end
    end

    def set_from(from_email)
      @from = from_email
    end

    def set_from_name(from_name)
      @from_name = from_name
    end

    def set_subject(subject)
      @subject = subject
    end

    def set_text(text)
      @text = text
    end

    def set_html(html)
      @html = html
    end
    
    def add_bcc(bcc_email)
      @bcc ||= Array.new

      if bcc_email.is_a?(Array)
        bcc_email.each do |email|
          @bcc << email
        end
      else  
        @bcc << bcc_email
      end
    end

    def set_reply_to(reply_to)
      @reply_to = reply_to
    end

    def set_date(date)
      @date = date
    end

    def add_files(file)
      @attachments.push(get_file_info(file))
    end 

    def get_file_info(file)
      dir, basename = File::split(file)
      extname = File::extname(file)
      filename = File::basename(file, extname)
      info = {
        'dirname' => dir,
        'basename' => basename,
        'extension' => extname,
        'filename' => filename
      }
      info['file'] = file
      info
    end

    def add_headers(key, value)
      @headers ||= {}
      @headers[key] = value
    end

    def set_x_smtpapi(key, value)
      @xsmtpapi ||= {}
      @xsmtpapi[key] = value
    end   

  end    
end

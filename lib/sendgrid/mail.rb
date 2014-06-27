require "json"

module SendGrid
  class Mail

    attr_accessor :endpoint, :to, :from, :from_name, :subject, :text, :html, :bcc

    def initialize(params = {})
      @endpoint = "/api/mail.send.json"
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

        bcc_email.each do
          @bcc << bcc_email
        end

      else  
      @bcc << bcc_email
    end

    end

    def add_bccs(bccs = {})
      #add stuff
    end

    def set_reply_to(reply_to)
      #add stuff
    end

    def set_date(date)
      #add stuff
    end 

    def add_files(files = {})
      #add stuff
    end 

    def add_content(content_ids = {})
      #add stuff
    end

    def add_headers(headers = {})
      #add stuff
    end

    # def set_x_smtpapi(json{})

    # end   

  end    
end

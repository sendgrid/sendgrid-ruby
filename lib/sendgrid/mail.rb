require "json"

module SendGrid
  class Mail

    def initialize(to)
      @endpoint = "/api/mail.send.json"
    end

    attr_accessor :endpoint, :to, :from, :subject, :text

    def add_to(to_email)
      @to = to_email
    end
    
    def add_tos(to_emails = {})
      @tos = Array.new(10) { iii }
    end

    def add_to_name(to_name)
      #add stuff
    end

    def add_to_names(to_names = {})
      #add stuff
    end

    def set_from(from_email)
      @from = from_email
    end

    def set_from_email(from_name)
      #add stuff
    end

    def set_subject(subject)
      @subject = subject
    end

    def set_text(text)
      @text = text
    end

    def set_html(html)
      #add stuff
    end

    # def set_x_smtpapi(json{})

    # end
    
    def add_bcc(bcc)
      #add stuff
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

  end    
end

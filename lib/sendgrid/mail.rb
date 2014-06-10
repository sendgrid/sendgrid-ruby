require "json"

module SendGrid
  class Mail

    def initialize()
      @endpoint = "/api/mail.send.json?"
    end

    attr_reader :to_email,

    def add_to(to_email)
      #add stuff
    end
    
    def add_tos(to_emails = {})
      #add stuff
    end

    def add_to_name(name)
      #add stuff
    end

    def add_to_names(names = {})
      #add stuff
    end

    def set_from(from_email)
      #add stuff
    end

    def set_from_email(from_name)
      #add stuff
    end

    def set_subject(subject)
      #add stuff
    end

    def set_text(text, format)
      #add stuff
    end

    def set_html(html, something = {}, inject(Array.new) { |arr, a| arr.push(*a) })
      #add stuff
    end

    def set_x_smtpapi(json{})

    end
    
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




##
  ##  THIS IS HOW I WANNA USE IT.
    #  sg = sendgrid.Client.new("Myuser", "Mykey")
    #  m = sendgrid.Mail.new()
    #  m.add_to("robin@sendgrid.com")
    #  sg.send(m)

    ##   OR

    #  m = sendgrid.Mail.new(:to => "me@rbin.co", :from => "tits@mcgee.me")
    #  sg.send(m)
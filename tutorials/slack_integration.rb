require 'sinatra'
require 'sendgrid-ruby'

class API < Sinatra::Base
  include SendGrid

  COMMAND_SENDMAIL = '/sendmail'

  post '/commands' do
    begin
      data = request.params
      return 401 if data['token'] != ENV['SLACK_SENDMAIL_TOKEN'] # Unauthorized
      case data['command']
      when COMMAND_SENDMAIL
        fields = self.parse_fields(data['text'].strip, COMMAND_SENDMAIL)
        to_list = fields['to_list'].split(',')
        subject = fields['subject']
        body = fields['body']
        from = data['team_domain'].capitalize
        from = Email.new(email: from + '@example.com')
        content = Content.new(type: 'text/plain', value: body)
        mail = Mail.new
        mail.from = from
        to_list.each do |to|
          next if !self.valid_email(to)
          personlization = Personalization.new
          to = Email.new(email: to.strip)
          personlization.add_to(to)
          mail.add_personalization(personlization)
        end
        mail.subject = subject
        mail.add_content(content)
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        if response.status_code == "202"
          return "Email sent :+1:"
        else
          body = JSON.parse(response.body)
          return "Sorry there was some issue while sending email.\n This is the error we got: _#{body['errors'].collect{|e| e['message']}.join(" ,")}_ \nPlease try again :cry:"
        end
      else
        return "Command not found"
      end
    rescue Exception => _
      return "Something went wrong. Please try again after sometime :cry:"
    end
  end


  def parse_fields(data, command)
    fields = {}
    return fields if data.nil?
    case command
    when COMMAND_SENDMAIL
      regex = /^\/to\s(?<to_list>\S+)\s*\/subject(?<subject>.*)\/body(?<body>.*)$/
      fields = data.match(regex)
    end
    return fields
  end

  def valid_email(email)
    regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    if email.match(regex)
      return true
    else
      return false
    end
  end

end

API.run!
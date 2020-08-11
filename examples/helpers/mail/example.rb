require 'sendgrid-ruby'
include SendGrid
require 'json'

def hello_world
  from = Email.new(email: 'test@example.com')
  subject = 'Hello World from the Twilio SendGrid Ruby Library'
  to = Email.new(email: 'test@example.com')
  content = Content.new(type: 'text/plain', value: 'some text here')
  mail = SendGrid::Mail.new(from, subject, to, content)
  # puts JSON.pretty_generate(mail.to_json)
  puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end

def kitchen_sink
  mail = SendGrid::Mail.new
  mail.from = Email.new(email: 'test@example.com')
  mail.subject = 'Hello World from the Twilio SendGrid Ruby Library'
  personalization = Personalization.new
  personalization.add_to(Email.new(email: 'test1@example.com', name: 'Example User'))
  personalization.add_to(Email.new(email: 'test2@example.com', name: 'Example User'))
  personalization.add_cc(Email.new(email: 'test3@example.com', name: 'Example User'))
  personalization.add_cc(Email.new(email: 'test4@example.com', name: 'Example User'))
  personalization.add_bcc(Email.new(email: 'test5@example.com', name: 'Example User'))
  personalization.add_bcc(Email.new(email: 'test6@example.com', name: 'Example User'))
  personalization.subject = 'Hello World from the Personalized Twilio SendGrid Ruby Library'
  personalization.add_header(Header.new(key: 'X-Test', value: 'True'))
  personalization.add_header(Header.new(key: 'X-Mock', value: 'False'))
  personalization.add_substitution(Substitution.new(key: '%name%', value: 'Example User'))
  personalization.add_substitution(Substitution.new(key: '%city%', value: 'Denver'))
  personalization.add_custom_arg(CustomArg.new(key: 'user_id', value: '343'))
  personalization.add_custom_arg(CustomArg.new(key: 'type', value: 'marketing'))
  personalization.send_at = 1443636843
  mail.add_personalization(personalization)

  personalization2 = Personalization.new
  personalization2.add_to(Email.new(email: 'test1@example.com', name: 'Example User'))
  personalization2.add_to(Email.new(email: 'test2@example.com', name: 'Example User'))
  personalization2.add_cc(Email.new(email: 'test3@example.com', name: 'Example User'))
  personalization2.add_cc(Email.new(email: 'test4@example.com', name: 'Example User'))
  personalization2.add_bcc(Email.new(email: 'test5@example.com', name: 'Example User'))
  personalization2.add_bcc(Email.new(email: 'test6@example.com', name: 'Example User'))
  personalization2.subject = 'Hello World from the Personalized Twilio SendGrid Ruby Library'
  personalization2.add_header(Header.new(key: 'X-Test', value: 'True'))
  personalization2.add_header(Header.new(key: 'X-Mock', value: 'False'))
  personalization2.add_substitution(Substitution.new(key: '%name%', value: 'Example User'))
  personalization2.add_substitution(Substitution.new(key: '%city%', value: 'Denver'))
  personalization2.add_custom_arg(CustomArg.new(key: 'user_id', value: '343'))
  personalization2.add_custom_arg(CustomArg.new(key: 'type', value: 'marketing'))
  personalization2.send_at = 1443636843
  mail.add_personalization(personalization2)

  mail.add_content(Content.new(type: 'text/plain', value: 'some text here'))
  mail.add_content(Content.new(type: 'text/html', value: '<html><body>some text here</body></html>'))

  attachment = Attachment.new
  attachment.content = 'TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQ3JhcyBwdW12'
  attachment.type = 'application/pdf'
  attachment.filename = 'balance_001.pdf'
  attachment.disposition = 'attachment'
  attachment.content_id = 'Balance Sheet'
  mail.add_attachment(attachment)

  attachment2 = Attachment.new
  attachment2.content = 'BwdW'
  attachment2.type = 'image/png'
  attachment2.filename = 'banner.png'
  attachment2.disposition = 'inline'
  attachment2.content_id = 'Banner'
  mail.add_attachment(attachment2)

  mail.template_id = '13b8f94f-bcae-4ec6-b752-70d6cb59f932'

  mail.add_section(Section.new(key: '%section1%', value: 'Substitution Text for Section 1'))
  mail.add_section(Section.new(key: '%section2%', value: 'Substitution Text for Section 2'))

  mail.add_header(Header.new(key: 'X-Test3', value: 'test3'))
  mail.add_header(Header.new(key: 'X-Test4', value: 'test4'))

  mail.add_category(Category.new(name: 'May'))
  mail.add_category(Category.new(name: '2016'))

  mail.add_custom_arg(CustomArg.new(key: 'campaign', value: 'welcome'))
  mail.add_custom_arg(CustomArg.new(key: 'weekday', value: 'morning'))

  mail.send_at = 1443636842

  # This must be a valid [batch ID](https://sendgrid.com/docs/API_Reference/SMTP_API/scheduling_parameters.html) to work
  # mail.batch_id = 'sendgrid_batch_id'

  mail.asm = ASM.new(group_id: 99, groups_to_display: [4,5,6,7,8])

  mail.ip_pool_name = '23'

  mail_settings = MailSettings.new
  mail_settings.bcc = BccSettings.new(enable: true, email: 'test@example.com')
  mail_settings.bypass_list_management = BypassListManagement.new(enable: true)
  mail_settings.footer = Footer.new(enable: true, text: 'Footer Text', html: '<html><body>Footer Text</body></html>')
  mail_settings.sandbox_mode = SandBoxMode.new(enable: true)
  mail_settings.spam_check = SpamCheck.new(enable: true, threshold: 1, post_to_url: 'https://spamcatcher.sendgrid.com')
  mail.mail_settings = mail_settings

  tracking_settings = TrackingSettings.new
  tracking_settings.click_tracking = ClickTracking.new(enable: false, enable_text: false)
  tracking_settings.open_tracking = OpenTracking.new(enable: true, substitution_tag: 'Optional tag to replace with the open image in the body of the message')
  tracking_settings.subscription_tracking = SubscriptionTracking.new(enable: true, text: 'text to insert into the text/plain portion of the message', html: 'html to insert into the text/html portion of the message', substitution_tag: 'Optional tag to replace with the open image in the body of the message')
  tracking_settings.ganalytics = Ganalytics.new(enable: true, utm_source: 'some source', utm_medium: 'some medium', utm_term: 'some term', utm_content: 'some content', utm_campaign: 'some campaign')
  mail.tracking_settings = tracking_settings

  mail.reply_to = Email.new(email: 'test@example.com')

  # puts JSON.pretty_generate(mail.to_json)
  puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end

def dynamic_template_data_hello_world
  mail = Mail.new
  mail.template_id = '' # a non-legacy template id
  mail.from = Email.new(email: 'test@example.com')
  personalization = Personalization.new
  personalization.add_to(Email.new(email: 'test1@example.com', name: 'Example User'))
  personalization.add_dynamic_template_data({
    "variable" => [
      {"foo" => "bar"}, {"foo" => "baz"}
    ]
  })
  mail.add_personalization(personalization)
  
  # puts JSON.pretty_generate(mail.to_json)
  puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end

hello_world
kitchen_sink
dynamic_template_data_hello_world


require_relative "../../../lib/helpers/mail/mail"
require_relative "../../../lib/sendgrid-ruby"
include SendGrid
require "json"
require 'minitest/autorun'

class TestMail < Minitest::Test
  def setup
  end

  def test_hello_world
    mail = Mail.new()
    mail.from = Email.new(email: "dx@sendgrid.com")
    mail.subject = "Hello World from the SendGrid Ruby Library"
    personalization = Personalization.new()
    personalization.to = Email.new(email: "elmer.thomas@sendgrid.com")
    mail.personalizations = personalization
    mail.contents = Content.new(type: "text/plain", value: "some text here")
    mail.contents = Content.new(type: "text/html", value: "<html><body>some text here</body></html>")
    assert_equal(mail.to_json, JSON.parse('{"content":[{"type":"text/plain","value":"some text here"},{"type":"text/html","value":"<html><body>some text here</body></html>"}],"from":{"email":"dx@sendgrid.com"},"personalizations":[{"to":[{"email":"elmer.thomas@sendgrid.com"}]}],"subject":"Hello World from the SendGrid Ruby Library"}'))
  end

  def test_kitchen_sink
    mail = Mail.new()
    mail.from = Email.new(email: "dx@sendgrid.com")
    mail.subject = "Hello World from the SendGrid Ruby Library"
    personalization = Personalization.new()
    personalization.to = Email.new(email: "elmer.thomas@sendgrid.com", name: "Elmer Thomas")
    personalization.to = Email.new(email: "elmer.thomas@gmail.com", name: "Elmer Thomas Alias")
    personalization.cc = Email.new(email: "matt.bernier@sendgrid.com", name: "Matt Bernier")
    personalization.cc = Email.new(email: "eric.shallock@sendgrid.com", name: "Eric Shallock")
    personalization.bcc = Email.new(email: "matt.bernier+dx@sendgrid.com", name: "Matt Bernier DX")
    personalization.bcc = Email.new(email: "eric.shallock+dx@sendgrid.com", name: "Eric Shallock DX")
    personalization.subject = "Hello World from the Personalized SendGrid Python Library"
    personalization.headers = Header.new(key: "X-Test", value: "True")
    personalization.headers = Header.new(key: "X-Mock", value: "False")
    personalization.substitutions = Substitution.new(key: "%name%", value: "Tim")
    personalization.substitutions = Substitution.new(key: "%city%", value: "Riverside")
    personalization.custom_args = CustomArg.new(key: "user_id", value: "343")
    personalization.custom_args = CustomArg.new(key: "type", value: "marketing")
    personalization.send_at = 1443636843
    mail.personalizations = personalization

    personalization2 = Personalization.new()
    personalization2.to = Email.new(email: "elmer.thomas@sendgrid.com", name: "Elmer Thomas")
    personalization2.to = Email.new(email: "elmer.thomas@gmail.com", name: "Elmer Thomas Alias")
    personalization2.cc = Email.new(email: "matt.bernier@sendgrid.com", name: "Matt Bernier")
    personalization2.cc = Email.new(email: "eric.shallock@sendgrid.com", name: "Eric Shallock")
    personalization2.bcc = Email.new(email: "matt.bernier+dx@sendgrid.com", name: "Matt Bernier DX")
    personalization2.bcc = Email.new(email: "eric.shallock+dx@sendgrid.com", name: "Eric Shallock DX")
    personalization2.subject = "Hello World from the Personalized SendGrid Python Library"
    personalization2.headers = Header.new(key: "X-Test", value: "True")
    personalization2.headers = Header.new(key: "X-Mock", value: "False")
    personalization2.substitutions = Substitution.new(key: "%name%", value: "Tim")
    personalization2.substitutions = Substitution.new(key: "%city%", value: "Riverside")
    personalization2.custom_args = CustomArg.new(key: "user_id", value: "343")
    personalization2.custom_args = CustomArg.new(key: "type", value: "marketing")
    personalization2.send_at = 1443636843
    mail.personalizations = personalization2

    mail.contents = Content.new(type: "text/plain", value: "some text here")
    mail.contents = Content.new(type: "text/html", value: "<html><body>some text here</body></html>")

    attachment = Attachment.new()
    attachment.content = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQ3JhcyBwdW12"
    attachment.type = "application/pdf"
    attachment.filename = "balance_001.pdf"
    attachment.disposition = "attachment"
    attachment.content_id = "Balance Sheet"

    mail.attachments = attachment

    attachment2 = Attachment.new()
    attachment2.content = "BwdW"
    attachment2.type = "image/png"
    attachment2.filename = "banner.png"
    attachment2.disposition = "inline"
    attachment2.content_id = "Banner"
    mail.attachments = attachment2

    mail.template_id = "13b8f94f-bcae-4ec6-b752-70d6cb59f932"

    mail.sections = Section.new(key: "%section1%", value: "Substitution Text for Section 1")
    mail.sections = Section.new(key: "%section2%", value: "Substitution Text for Section 2")

    mail.headers = Header.new(key: "X-Test3", value: "test3")
    mail.headers = Header.new(key: "X-Test4", value: "test4")

    mail.categories = Category.new(name: "May")
    mail.categories = Category.new(name: "2016")

    mail.custom_args = CustomArg.new(key: "campaign", value: "welcome")
    mail.custom_args = CustomArg.new(key: "weekday", value: "morning")

    mail.send_at = 1443636842

    mail.batch_id = "sendgrid_batch_id"

    mail.asm = ASM.new(group_id: 99, groups_to_display: [4,5,6,7,8])

    mail.ip_pool_name = "23"

    mail_settings = MailSettings.new()
    mail_settings.bcc = BccSettings.new(enable: true, email: "dx@sendgrid.com")
    mail_settings.bypass_list_management = BypassListManagement.new(enable: true)
    mail_settings.footer = Footer.new(enable: true, text: "Footer Text", html: "<html><body>Footer Text</body></html>")
    mail_settings.sandbox_mode = SandBoxMode.new(enable: true)
    mail_settings.spam_check = SpamCheck.new(enable: true, threshold: 1, post_to_url: "https://spamcatcher.sendgrid.com")
    mail.mail_settings = mail_settings

    tracking_settings = TrackingSettings.new()
    tracking_settings.click_tracking = ClickTracking.new(enable: false, enable_text: false)
    tracking_settings.open_tracking = OpenTracking.new(enable: true, substitution_tag: "Optional tag to replace with the open image in the body of the message")
    tracking_settings.subscription_tracking = SubscriptionTracking.new(enable: true, text: "text to insert into the text/plain portion of the message", html: "html to insert into the text/html portion of the message", substitution_tag: "Optional tag to replace with the open image in the body of the message")
    tracking_settings.ganalytics = Ganalytics.new(enable: true, utm_source: "some source", utm_medium: "some medium", utm_term: "some term", utm_content: "some content", utm_campaign: "some campaign")
    mail.tracking_settings = tracking_settings

    mail.reply_to = Email.new(email: "dx@sendgrid.com")

    assert_equal(mail.to_json, JSON.parse('{"asm":{"group_id":99,"groups_to_display":[4,5,6,7,8]},"attachments":[{"content":"TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQ3JhcyBwdW12","content_id":"Balance Sheet","disposition":"attachment","filename":"balance_001.pdf","type":"application/pdf"},{"content":"BwdW","content_id":"Banner","disposition":"inline","filename":"banner.png","type":"image/png"}],"batch_id":"sendgrid_batch_id","categories":["May","2016"],"content":[{"type":"text/plain","value":"some text here"},{"type":"text/html","value":"<html><body>some text here</body></html>"}],"custom_args":{"campaign":"welcome","weekday":"morning"},"from":{"email":"dx@sendgrid.com"},"headers":{"X-Test3":"test3","X-Test4":"test4"},"ip_pool_name":"23","mail_settings":{"bcc":{"email":"dx@sendgrid.com","enable":true},"bypass_list_management":{"enable":true},"footer":{"enable":true,"html":"<html><body>Footer Text</body></html>","text":"Footer Text"},"sandbox_mode":{"enable":true},"spam_check":{"enable":true,"post_to_url":"https://spamcatcher.sendgrid.com","threshold":1}},"personalizations":[{"bcc":[{"email":"matt.bernier+dx@sendgrid.com","name":"Matt Bernier DX"},{"email":"eric.shallock+dx@sendgrid.com","name":"Eric Shallock DX"}],"cc":[{"email":"matt.bernier@sendgrid.com","name":"Matt Bernier"},{"email":"eric.shallock@sendgrid.com","name":"Eric Shallock"}],"custom_args":{"type":"marketing","user_id":"343"},"headers":{"X-Mock":"False","X-Test":"True"},"send_at":1443636843,"subject":"Hello World from the Personalized SendGrid Python Library","substitutions":{"%city%":"Riverside","%name%":"Tim"},"to":[{"email":"elmer.thomas@sendgrid.com","name":"Elmer Thomas"},{"email":"elmer.thomas@gmail.com","name":"Elmer Thomas Alias"}]},{"bcc":[{"email":"matt.bernier+dx@sendgrid.com","name":"Matt Bernier DX"},{"email":"eric.shallock+dx@sendgrid.com","name":"Eric Shallock DX"}],"cc":[{"email":"matt.bernier@sendgrid.com","name":"Matt Bernier"},{"email":"eric.shallock@sendgrid.com","name":"Eric Shallock"}],"custom_args":{"type":"marketing","user_id":"343"},"headers":{"X-Mock":"False","X-Test":"True"},"send_at":1443636843,"subject":"Hello World from the Personalized SendGrid Python Library","substitutions":{"%city%":"Riverside","%name%":"Tim"},"to":[{"email":"elmer.thomas@sendgrid.com","name":"Elmer Thomas"},{"email":"elmer.thomas@gmail.com","name":"Elmer Thomas Alias"}]}],"reply_to":{"email":"dx@sendgrid.com"},"sections":{"%section1%":"Substitution Text for Section 1","%section2%":"Substitution Text for Section 2"},"send_at":1443636842,"subject":"Hello World from the SendGrid Ruby Library","template_id":"13b8f94f-bcae-4ec6-b752-70d6cb59f932","tracking_settings":{"click_tracking":{"enable":false,"enable_text":false},"ganalytics":{"enable":true,"utm_campaign":"some campaign","utm_content":"some content","utm_medium":"some medium","utm_source":"some source","utm_term":"some term"},"open_tracking":{"enable":true,"substitution_tag":"Optional tag to replace with the open image in the body of the message"},"subscription_tracking":{"enable":true,"html":"html to insert into the text/html portion of the message","substitution_tag":"Optional tag to replace with the open image in the body of the message","text":"text to insert into the text/plain portion of the message"}}}'))
  end
end

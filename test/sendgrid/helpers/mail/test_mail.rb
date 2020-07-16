require_relative "../../../../lib/sendgrid/helpers/mail/mail"
require_relative "../../../../lib/sendgrid/sendgrid"
include SendGrid
require "json"
require 'minitest/autorun'

class TestMail < Minitest::Test
  def setup
  end

  def test_hello_world
    from = Email.new(email: 'test@example.com')
    to = Email.new(email: 'test@example.com')
    subject = 'Sending with Twilio SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = SendGrid::Mail.new(from, subject, to, content)

    assert_equal(mail.to_json, JSON.parse('{"from":{"email":"test@example.com"}, "subject":"Sending with Twilio SendGrid is Fun", "personalizations":[{"to":[{"email":"test@example.com"}]}], "content":[{"type":"text/plain", "value":"and easy to do anywhere, even with Ruby"}]}'))
  end

  def test_kitchen_sink
    mail = SendGrid::Mail.new
    mail.from = Email.new(email: "test@example.com")
    mail.subject = "Hello World from the Twilio SendGrid Ruby Library"
    personalization = Personalization.new
    personalization.add_to(Email.new(email: "test@example.com", name: "Example User"))
    personalization.add_to(Email.new(email: "test@example.com", name: "Example User"))
    personalization.add_cc(Email.new(email: "test@example.com", name: "Example User"))
    personalization.add_cc(Email.new(email: "test@example.com", name: "Example User"))
    personalization.add_bcc(Email.new(email: "test@example.com", name: "Example User"))
    personalization.add_bcc(Email.new(email: "test@example.com", name: "Example User"))
    personalization.subject = "Hello World from the Personalized Twilio SendGrid Ruby Library"
    personalization.add_header(Header.new(key: "X-Test", value: "True"))
    personalization.add_header(Header.new(key: "X-Mock", value: "False"))
    personalization.add_substitution(Substitution.new(key: "%name%", value: "Example User"))
    personalization.add_substitution(Substitution.new(key: "%city%", value: "Denver"))
    personalization.add_custom_arg(CustomArg.new(key: "user_id", value: "343"))
    personalization.add_custom_arg(CustomArg.new(key: "type", value: "marketing"))
    personalization.send_at = 1443636843
    mail.add_personalization(personalization)

    personalization2 = Personalization.new
    personalization2.add_to(Email.new(email: "test@example.com", name: "Example User"))
    personalization2.add_to(Email.new(email: "test@example.com", name: "Example User"))
    personalization2.add_cc(Email.new(email: "test@example.com", name: "Example User"))
    personalization2.add_cc(Email.new(email: "test@example.com", name: "Example User"))
    personalization2.add_bcc(Email.new(email: "test@example.com", name: "Example User"))
    personalization2.add_bcc(Email.new(email: "test@example.com", name: "Example User"))
    personalization2.subject = "Hello World from the Personalized Twilio SendGrid Ruby Library"
    personalization2.add_header(Header.new(key: "X-Test", value: "True"))
    personalization2.add_header(Header.new(key: "X-Mock", value: "False"))
    personalization2.add_substitution(Substitution.new(key: "%name%", value: "Example User"))
    personalization2.add_substitution(Substitution.new(key: "%city%", value: "Denver"))
    personalization2.add_custom_arg(CustomArg.new(key: "user_id", value: "343"))
    personalization2.add_custom_arg(CustomArg.new(key: "type", value: "marketing"))
    personalization2.send_at = 1443636843
    mail.add_personalization(personalization2)

    mail.add_content(Content.new(type: "text/plain", value: "some text here"))
    mail.add_content(Content.new(type: "text/html", value: "<html><body>some text here</body></html>"))

    attachment = Attachment.new
    attachment.content = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQ3JhcyBwdW12"
    attachment.type = "application/pdf"
    attachment.filename = "balance_001.pdf"
    attachment.disposition = "attachment"
    attachment.content_id = "Balance Sheet"

    mail.add_attachment(attachment)

    attachment2 = Attachment.new
    attachment2.content = "BwdW"
    attachment2.type = "image/png"
    attachment2.filename = "banner.png"
    attachment2.disposition = "inline"
    attachment2.content_id = "Banner"
    mail.add_attachment(attachment2)

    mail.template_id = "13b8f94f-bcae-4ec6-b752-70d6cb59f932"

    mail.add_section(Section.new(key: "%section1%", value: "Substitution Text for Section 1"))
    mail.add_section(Section.new(key: "%section2%", value: "Substitution Text for Section 2"))

    mail.add_header(Header.new(key: "X-Test3", value: "test3"))
    mail.add_header(Header.new(key: "X-Test4", value: "test4"))

    mail.add_category(Category.new(name: "May"))
    mail.add_category(Category.new(name: "2016"))

    mail.add_custom_arg(CustomArg.new(key: "campaign", value: "welcome"))
    mail.add_custom_arg(CustomArg.new(key: "weekday", value: "morning"))

    mail.send_at = 1443636842

    mail.batch_id = "sendgrid_batch_id"

    mail.asm = ASM.new(group_id: 99, groups_to_display: [4,5,6,7,8])

    mail.ip_pool_name = "23"

    mail_settings = MailSettings.new
    mail_settings.bcc = BccSettings.new(enable: true, email: "test@example.com")
    mail_settings.bypass_list_management = BypassListManagement.new(enable: true)
    mail_settings.footer = Footer.new(enable: true, text: "Footer Text", html: "<html><body>Footer Text</body></html>")
    mail_settings.sandbox_mode = SandBoxMode.new(enable: true)
    mail_settings.spam_check = SpamCheck.new(enable: true, threshold: 1, post_to_url: "https://spamcatcher.sendgrid.com")
    mail.mail_settings = mail_settings

    tracking_settings = TrackingSettings.new
    tracking_settings.click_tracking = ClickTracking.new(enable: false, enable_text: false)
    tracking_settings.open_tracking = OpenTracking.new(enable: true, substitution_tag: "Optional tag to replace with the open image in the body of the message")
    tracking_settings.subscription_tracking = SubscriptionTracking.new(enable: true, text: "text to insert into the text/plain portion of the message", html: "html to insert into the text/html portion of the message", substitution_tag: "Optional tag to replace with the open image in the body of the message")
    tracking_settings.ganalytics = Ganalytics.new(enable: true, utm_source: "some source", utm_medium: "some medium", utm_term: "some term", utm_content: "some content", utm_campaign: "some campaign")
    mail.tracking_settings = tracking_settings

    mail.reply_to = Email.new(email: "test@example.com")

    assert_equal(mail.to_json, JSON.parse('{"asm":{"group_id":99,"groups_to_display":[4,5,6,7,8]},"attachments":[{"content":"TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQ3JhcyBwdW12","content_id":"Balance Sheet","disposition":"attachment","filename":"balance_001.pdf","type":"application/pdf"},{"content":"BwdW","content_id":"Banner","disposition":"inline","filename":"banner.png","type":"image/png"}],"batch_id":"sendgrid_batch_id","categories":["May","2016"],"content":[{"type":"text/plain","value":"some text here"},{"type":"text/html","value":"<html><body>some text here</body></html>"}],"custom_args":{"campaign":"welcome","weekday":"morning"},"from":{"email":"test@example.com"},"headers":{"X-Test3":"test3","X-Test4":"test4"},"ip_pool_name":"23","mail_settings":{"bcc":{"email":"test@example.com","enable":true},"bypass_list_management":{"enable":true},"footer":{"enable":true,"html":"<html><body>Footer Text</body></html>","text":"Footer Text"},"sandbox_mode":{"enable":true},"spam_check":{"enable":true,"post_to_url":"https://spamcatcher.sendgrid.com","threshold":1}},"personalizations":[{"bcc":[{"email":"test@example.com","name":"Example User"},{"email":"test@example.com","name":"Example User"}],"cc":[{"email":"test@example.com","name":"Example User"},{"email":"test@example.com","name":"Example User"}],"custom_args":{"type":"marketing","user_id":"343"},"headers":{"X-Mock":"False","X-Test":"True"},"send_at":1443636843,"subject":"Hello World from the Personalized Twilio SendGrid Ruby Library","substitutions":{"%city%":"Denver","%name%":"Example User"},"to":[{"email":"test@example.com","name":"Example User"},{"email":"test@example.com","name":"Example User"}]},{"bcc":[{"email":"test@example.com","name":"Example User"},{"email":"test@example.com","name":"Example User"}],"cc":[{"email":"test@example.com","name":"Example User"},{"email":"test@example.com","name":"Example User"}],"custom_args":{"type":"marketing","user_id":"343"},"headers":{"X-Mock":"False","X-Test":"True"},"send_at":1443636843,"subject":"Hello World from the Personalized Twilio SendGrid Ruby Library","substitutions":{"%city%":"Denver","%name%":"Example User"},"to":[{"email":"test@example.com","name":"Example User"},{"email":"test@example.com","name":"Example User"}]}],"reply_to":{"email":"test@example.com"},"sections":{"%section1%":"Substitution Text for Section 1","%section2%":"Substitution Text for Section 2"},"send_at":1443636842,"subject":"Hello World from the Twilio SendGrid Ruby Library","template_id":"13b8f94f-bcae-4ec6-b752-70d6cb59f932","tracking_settings":{"click_tracking":{"enable":false,"enable_text":false},"ganalytics":{"enable":true,"utm_campaign":"some campaign","utm_content":"some content","utm_medium":"some medium","utm_source":"some source","utm_term":"some term"},"open_tracking":{"enable":true,"substitution_tag":"Optional tag to replace with the open image in the body of the message"},"subscription_tracking":{"enable":true,"html":"html to insert into the text/html portion of the message","substitution_tag":"Optional tag to replace with the open image in the body of the message","text":"text to insert into the text/plain portion of the message"}}}'))
  end

  def test_that_personalizations_is_empty_initially
    mail = SendGrid::Mail.new
    assert_equal([], mail.personalizations)
  end

  def test_that_contents_is_empty_initially
    mail = SendGrid::Mail.new
    assert_equal([], mail.contents)
  end

  def test_that_attachments_is_empty_initially
    mail = SendGrid::Mail.new
    assert_equal([], mail.attachments)
  end

  def test_that_categories_is_empty_initially
    mail = SendGrid::Mail.new
    assert_equal([], mail.categories)
  end

  def test_add_personalization
    mail = SendGrid::Mail.new
    mail.add_personalization('foo')
    assert_equal(['foo'.to_json], mail.personalizations)
  end

  def test_add_content
    mail = SendGrid::Mail.new
    mail.add_content('foo')
    assert_equal(['foo'.to_json], mail.contents)
  end

  def test_add_section
    mail = SendGrid::Mail.new
    mail.add_section(Section.new(key: '%section1%', value: 'Substitution Text for Section 1'))
    expected_json = {
        "sections"=>{
                "%section1%"=>"Substitution Text for Section 1"
            }
    }
    assert_equal mail.to_json, expected_json
    mail.add_section(Section.new(key: '%section2%', value: 'Substitution Text for Section 2'))
    expected_json = {
        "sections"=>{
                "%section1%"=>"Substitution Text for Section 1",
                "%section2%"=>"Substitution Text for Section 2"
            }
    }
    assert_equal mail.to_json, expected_json
  end

  def test_add_header
    mail = SendGrid::Mail.new
    mail.add_header(Header.new(key: 'X-Test3', value: 'test3'))
    expected_json = {
        "headers"=>{
                "X-Test3"=>"test3"
            }
    }
    assert_equal mail.to_json, expected_json
    mail.add_header(Header.new(key: 'X-Test4', value: 'test4'))
    expected_json = {
        "headers"=>{
                "X-Test3"=>"test3",
                "X-Test4"=>"test4"
            }
    }
    assert_equal mail.to_json, expected_json
  end

  def test_add_custom_arg
    mail = SendGrid::Mail.new
    mail.add_custom_arg(CustomArg.new(key: 'campaign 1', value: 'welcome 1'))
    expected_json = {
        "custom_args"=>{
                "campaign 1"=>"welcome 1"
            }
    }
    assert_equal mail.to_json, expected_json
    mail.add_custom_arg(CustomArg.new(key: 'campaign 2', value: 'welcome 2'))
    expected_json = {
        "custom_args"=>{
                "campaign 1"=>"welcome 1",
                "campaign 2"=>"welcome 2"
            }
    }
    assert_equal mail.to_json, expected_json
  end

  def test_add_non_string_custom_arg
    mail = Mail.new
    mail.add_custom_arg(CustomArg.new(key: "Integer", value: 1))
    mail.add_custom_arg(CustomArg.new(key: "Array", value: [1, "a", true]))
    mail.add_custom_arg(CustomArg.new(key: "Hash", value: {"a" => 1, "b" => 2}))
    expected_json = {
        "custom_args"=>{
                "Integer"=>"1",
                "Array"=>"[1, \"a\", true]",
                "Hash"=>"{\"a\"=>1, \"b\"=>2}",
            }
    }
    assert_equal mail.to_json, expected_json
  end

  def test_add_attachment
    mail = SendGrid::Mail.new
    mail.add_attachment('foo')
    assert_equal(['foo'.to_json], mail.attachments)
  end

  def test_add_valid_category
    mail = SendGrid::Mail.new
    category = Category.new(name: 'foo')
    mail.add_category(category)
    assert_equal(['foo'], mail.categories)
  end

  def test_add_more_than_1_valid_category
    mail = SendGrid::Mail.new
    category_1 = Category.new(name: 'foo')
    category_2 = Category.new(name: 'bar')
    mail.add_category(category_1)
    mail.add_category(category_2)
    assert_equal(['foo', 'bar'], mail.categories)
  end

  def test_add_invalid_category
    mail = SendGrid::Mail.new
    assert_raises(NoMethodError) do
      mail.add_category('foo')
    end
  end

  def test_check_for_secrets
    mail = Mail.new
    mail.add_content(Content.new(type: 'text/plain', value: 'Sensitive information: SG.a123b456'))
    assert_raises(SecurityError) do
      mail.check_for_secrets([/SG.[a-zA-Z0-9_-]*/])
    end
  end
end

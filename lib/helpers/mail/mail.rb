# Build the request body for the v3/mail/send endpoint
# Please see the examples/helpers/mail/example.rb for a demonstration of usage
require 'json'

module SendGrid
  class Ganalytics
    def initialize(enable: nil, utm_source: nil, utm_medium: nil, utm_term: nil, utm_content: nil, utm_campaign: nil, utm_name: nil)
      @enable = enable
      @utm_source = utm_source
      @utm_medium = utm_medium
      @utm_term = utm_term
      @utm_content = utm_content
      @utm_campaign = utm_campaign
      @utm_name = utm_name
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def utm_source=(utm_source)
      @utm_source = utm_source
    end

    def utm_source
      @utm_source
    end

    def utm_medium=(utm_medium)
      @utm_medium = utm_medium
    end

    def utm_medium
      @utm_medium
    end

    def utm_term=(utm_term)
      @utm_term = utm_term
    end

    def utm_term
      @utm_term
    end

    def utm_content=(utm_content)
      @utm_content = utm_content
    end

    def utm_content
      @utm_content
    end

    def utm_campaign=(utm_campaign)
      @utm_campaign = utm_campaign
    end

    def utm_campaign
      @utm_campaign
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'utm_source' => self.utm_source,
        'utm_medium' => self.utm_medium,
        'utm_term' => self.utm_term,
        'utm_content' => self.utm_content,
        'utm_campaign' => self.utm_campaign
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class SubscriptionTracking
    def initialize(enable: nil, text: nil, html: nil, substitution_tag: nil)
      @enable = enable
      @text = text
      @html = html
      @substitution_tag = substitution_tag
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def text=(text)
      @text = text
    end

    def text
      @text
    end

    def html=(html)
      @html = html
    end

    def html
      @html
    end

    def substitution_tag=(substitution_tag)
      @substitution_tag = substitution_tag
    end

    def substitution_tag
      @substitution_tag
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'text' => self.text,
        'html' => self.html,
        'substitution_tag' => self.substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class OpenTracking
    def initialize(enable: nil, substitution_tag: nil)
      @enable = enable
      @substitution_tag = substitution_tag
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def substitution_tag=(substitution_tag)
      @substitution_tag = substitution_tag
    end

    def substitution_tag
      @substitution_tag
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'substitution_tag' => self.substitution_tag
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class ClickTracking
    def initialize(enable: nil, enable_text: nil)
      @enable = enable
      @enable_text = enable_text
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def enable_text=(enable_text)
      @enable_text = enable_text
    end

    def enable_text
      @enable_text
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'enable_text' => self.enable_text
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class TrackingSettings
    def initialize
      @click_tracking = nil
      @open_tracking = nil
      @subscription_tracking = nil
      @ganalytics = nil
    end

    def click_tracking=(click_tracking)
      @click_tracking = click_tracking
    end

    def click_tracking
      @click_tracking.nil? ? nil : @click_tracking.to_json
    end

    def open_tracking=(open_tracking)
      @open_tracking = open_tracking
    end

    def open_tracking
      @open_tracking.nil? ? nil : @open_tracking.to_json
    end

    def subscription_tracking=(subscription_tracking)
      @subscription_tracking = subscription_tracking
    end

    def subscription_tracking
      @subscription_tracking.nil? ? nil : @subscription_tracking.to_json
    end

    def ganalytics=(ganalytics)
      @ganalytics = ganalytics
    end

    def ganalytics
      @ganalytics.nil? ? nil : @ganalytics.to_json
    end

    def to_json(*)
      {
        'click_tracking' => self.click_tracking,
        'open_tracking' => self.open_tracking,
        'subscription_tracking' => self.subscription_tracking,
        'ganalytics' => self.ganalytics
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class SpamCheck
    def initialize(enable: nil, threshold: nil, post_to_url: nil)
      @enable = enable
      @threshold = threshold
      @post_to_url = post_to_url
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def threshold=(threshold)
      @threshold = threshold
    end

    def threshold
      @threshold
    end

    def post_to_url=(post_to_url)
      @post_to_url = post_to_url
    end

    def post_to_url
      @post_to_url
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'threshold' => self.threshold,
        'post_to_url' => self.post_to_url
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Footer
    def initialize(enable: nil, text: nil, html: nil)
      @enable = enable
      @text = text
      @html = html
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def text=(text)
      @text = text
    end

    def text
      @text
    end

    def html=(html)
      @html = html
    end

    def html
      @html
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'text' => self.text,
        'html' => self.html
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class BccSettings
    def initialize(enable: nil, email: nil)
      @enable = enable
      @email = email
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def email=(email)
      @email = email
    end

    def email
      @email
    end

    def to_json(*)
      {
        'enable' => self.enable,
        'email' => self.email
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class BypassListManagement
    def initialize(enable: nil)
      @enable = enable
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def to_json(*)
      {
        'enable' => self.enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class SandBoxMode
    def initialize(enable: nil)
      @enable = enable
    end

    def enable=(enable)
      @enable = enable
    end

    def enable
      @enable
    end

    def to_json(*)
      {
        'enable' => self.enable
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class MailSettings
    def initilize
      @bcc = nil
      @bypass_list_management = nil
      @footer = nil
      @sandbox_mode = nil
      @spam_check = nil
    end

    def sandbox_mode=(sandbox_mode)
      @sandbox_mode = sandbox_mode
    end

    def sandbox_mode
      @sandbox_mode.nil? ? nil : @sandbox_mode.to_json
    end

    def bypass_list_management=(bypass_list_management)
      @bypass_list_management = bypass_list_management
    end

    def bypass_list_management
      @bypass_list_management.nil? ? nil : @bypass_list_management.to_json
    end

    def footer=(footer)
      @footer = footer
    end

    def footer
      @footer.nil? ? nil : @footer.to_json
    end

    def bcc=(bcc)
      @bcc = bcc
    end

    def bcc
      @bcc.nil? ? nil : @bcc.to_json
    end

    def spam_check=(spam_check)
      @spam_check = spam_check
    end

    def spam_check
      @spam_check.nil? ? nil : @spam_check.to_json
    end

    def to_json(*)
      {
        'bcc' => self.bcc,
        'bypass_list_management' => self.bypass_list_management,
        'footer' => self.footer,
        'sandbox_mode' => self.sandbox_mode,
        'spam_check' => self.spam_check
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class ASM
    def initialize(group_id: nil, groups_to_display: nil)
      @group_id = group_id
      @groups_to_display = groups_to_display
    end

    def group_id=(group_id)
      @group_id = group_id
    end

    def group_id
      @group_id
    end

    def groups_to_display=(groups_to_display)
      @groups_to_display = groups_to_display
    end

    def groups_to_display
      @groups_to_display
    end

    def to_json(*)
      {
        'group_id' => self.group_id,
        'groups_to_display' => self.groups_to_display
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Category
    def initialize(name: nil)
      @category = name
    end

    def category=(category)
      @category = category
    end

    def category
      @category
    end

    def to_json(*)
      {
        'category' => self.category
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Section
    def initialize(key: nil, value: nil)
      @section = {}
      (key.nil? || value.nil?) ? @section = nil : @section[key] = value
    end

    def section=(section)
      @section = section
    end

    def section
      @section
    end

    def to_json(*)
      {
        'section' => self.section
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Attachment
    def initialize
      @content = nil
      @type = nil
      @filename = nil
      @disposition = nil
      @content_id = nil
    end

    def content=(content)
      @content = content
    end

    def content
      @content
    end

    def type=(type)
      @type = type
    end

    def type
      @type
    end

    def filename=(filename)
      @filename = filename
    end

    def filename
      @filename
    end

    def disposition=(disposition)
      @disposition = disposition
    end

    def disposition
      @disposition
    end

    def content_id=(content_id)
      @content_id = content_id
    end

    def content_id
      @content_id
    end

    def to_json(*)
      {
        'content' => self.content,
        'type' => self.type,
        'filename' => self.filename,
        'disposition' => self.disposition,
        'content_id' => self.content_id
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Header
    def initialize(key: nil, value: nil)
      @header = {}
      (key.nil? || value.nil?) ? @header = nil : @header[key] = value
    end

    def header=(header)
      @header = header
    end

    def header
      @header
    end

    def to_json(*)
      {
        'header' => self.header
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Substitution
    def initialize(key: nil, value: nil)
      @substitution = {}
      (key.nil? || value.nil?) ? @substitution = nil : @substitution[key] = value
    end

    def substitution=(substitution)
      @substitution = substitution
    end

    def substitution
      @substitution
    end

    def to_json(*)
      {
        'substitution' => self.substitution
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class CustomArg
    def initialize(key: nil, value: nil)
      @custom_arg = {}
      (key.nil? || value.nil?) ? @custom_arg = nil : @custom_arg[key] = value
    end

    def custom_arg=(custom_arg)
      @custom_arg = custom_arg
    end

    def custom_arg
      @custom_arg
    end

    def to_json(*)
      {
        'custom_arg' => self.custom_arg
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Content
    def initialize(type: nil, value: nil)
      @type = type
      @value = value
    end

    def type=(type)
      @type = type
    end

    def type
      @type
    end

    def value=(value)
      @value = value
    end

    def value
      @value
    end

    def to_json(*)
      {
        'type' => self.type,
        'value' => self.value
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Personalization
    def initilize
      @tos = nil
      @ccs = nil
      @bccs = nil
      @subject = nil
      @headers = nil
      @substitutions = nil
      @custom_args = nil
      @send_at = nil
    end

    def to=(to)
      @tos = @tos.nil? ? [] : @tos
      @tos = @tos.push(to.to_json)
    end

    def tos
      @tos
    end

    def cc=(cc)
      @ccs = @ccs.nil? ? [] : @ccs
      @ccs = @ccs.push(cc.to_json)
    end

    def ccs
      @ccs
    end

    def bcc=(bcc)
      @bccs = @bccs.nil? ? [] : @bccs
      @bccs = @bccs.push(bcc.to_json)
    end

    def bccs
      @bccs
    end

    def subject=(subject)
      @subject = subject
    end

    def subject
      @subject
    end

    def headers=(headers)
      @headers = @headers.nil? ? {} : @headers
      headers = headers.to_json
      @headers = @headers.merge(headers['header'])
    end

    def headers
      @headers
    end

    def substitutions=(substitutions)
      @substitutions = @substitutions.nil? ? {} : @substitutions
      substitutions = substitutions.to_json
      @substitutions = @substitutions.merge(substitutions['substitution'])
    end

    def substitutions
      @substitutions
    end

    def custom_args=(custom_args)
      @custom_args = @custom_args.nil? ? {} : @custom_args
      custom_args = custom_args.to_json
      @custom_args = @custom_args.merge(custom_args['custom_arg'])
    end

    def custom_args
      @custom_args
    end

    def send_at=(send_at)
      @send_at = send_at
    end

    def send_at
      @send_at
    end

    def to_json(*)
      {
        'to' => self.tos,
        'cc' => self.ccs,
        'bcc' => self.bccs,
        'subject' => self.subject,
        'headers' => self.headers,
        'substitutions' => self.substitutions,
        'custom_args' => self.custom_args,
        'send_at' => self.send_at
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Email
    def initialize(email: nil, name: nil)
      @email = email
      @name = name
    end

    def email=(email)
      @email = email
    end

    def email
      @email
    end

    def name=(name)
      @name = name
    end

    def name
      @name
    end

    def to_json(*)
      {
        'email' => self.email,
        'name' => self.name
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end

  class Mail
    def initialize(from_email=nil, subj=nil, to_email=nil, cont=nil)
      @from = nil
      @subject = nil
      @personalizations = nil
      @contents = nil
      @attachments = nil
      @template_id = nil
      @sections = nil
      @headers = nil
      @categories = nil
      @custom_args = nil
      @send_at = nil
      @batch_id = nil
      @asm = nil
      @ip_pool_name = nil
      @mail_settings = nil
      @tracking_settings = nil
      @reply_to = nil

      if !(from_email.nil? && subj.nil? && to_email.nil? && cont.nil?)
        self.from = from_email
        self.subject = subj
        personalization = Personalization.new
        personalization.to = to_email
        self.personalizations = personalization
        self.contents = cont
      end
    end

    def from=(from)
      @from = from
    end

    def from
      @from.nil? ? nil : @from.to_json
    end

    def subject=(subject)
      @subject = subject
    end

    def subject
      @subject
    end

    def personalizations=(personalizations)
      @personalizations = @personalizations.nil? ? [] : @personalizations
      @personalizations = @personalizations.push(personalizations.to_json)
    end

    def personalizations
      @personalizations.nil? ? nil : @personalizations
    end

    def contents=(content)
      @contents = @contents ? @contents : []
      @contents = @contents.push(content.to_json)
    end

    def contents
      @contents
    end

    def attachments=(attachments)
      @attachments = @attachments.nil? ? [] : @attachments
      @attachments = @attachments.push(attachments.to_json)
    end

    def attachments
      @attachments
    end

    def template_id=(template_id)
      @template_id = template_id
    end

    def template_id
      @template_id
    end

    def sections=(sections)
      @sections = @sections.nil? ? {} : @sections
      sections = sections.to_json
      @sections = @sections.merge(sections['section'])
    end

    def sections
      @sections
    end

    def headers=(headers)
      @headers = @headers.nil? ? {} : @headers
      headers = headers.to_json
      @headers = @headers.merge(headers['header'])
    end

    def headers
      @headers
    end

    def categories=(category)
      @categories = @categories.nil? ? [] : @categories
      category = category.to_json
      @categories = @categories.push(category['category'])
    end

    def categories
      @categories
    end

    def custom_args=(custom_args)
      @custom_args = @custom_args.nil? ? {} : @custom_args
      custom_args = custom_args.to_json
      @custom_args = @custom_args.merge(custom_args['custom_arg'])
    end

    def custom_args
      @custom_args
    end

    def send_at=(send_at)
      @send_at = send_at
    end

    def send_at
      @send_at
    end

    def batch_id=(batch_id)
      @batch_id = batch_id
    end

    def batch_id
      @batch_id
    end

    def asm=(asm)
      @asm = asm
    end

    def asm
      @asm.nil? ? nil : @asm.to_json
    end

    def ip_pool_name=(ip_pool_name)
      @ip_pool_name = ip_pool_name
    end

    def ip_pool_name
      @ip_pool_name
    end

    def mail_settings=(mail_settings)
      @mail_settings = mail_settings
    end

    def mail_settings
      @mail_settings.nil? ? nil : @mail_settings.to_json
    end

    def tracking_settings=(tracking_settings)
      @tracking_settings = tracking_settings
    end

    def tracking_settings
      @tracking_settings.nil? ? nil : @tracking_settings.to_json
    end

    def reply_to=(reply_to)
      @reply_to = reply_to
    end

    def reply_to
      @reply_to.nil? ? nil : @reply_to.to_json
    end

    def to_json(*)
      {
        'from' => self.from,
        'subject' => self.subject,
        'personalizations' => self.personalizations,
        'content' => self.contents,
        'attachments' => self.attachments,
        'template_id' => self.template_id,
        'sections' => self.sections,
        'headers' => self.headers,
        'categories' => self.categories,
        'custom_args' => self.custom_args,
        'send_at' => self.send_at,
        'batch_id' => self.batch_id,
        'asm' => self.asm,
        'ip_pool_name' => self.ip_pool_name,
        'mail_settings' => self.mail_settings,
        'tracking_settings' => self.tracking_settings,
        'reply_to' => self.reply_to
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

require 'json'

module SendGrid
  class Personalization
    def initialize
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
end

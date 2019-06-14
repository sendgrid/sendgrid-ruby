require 'json'

module SendGrid
  class Personalization

    attr_reader :tos, :ccs, :bccs, :headers, :substitutions, :custom_args,
      :dynamic_template_data

    def initialize
      @tos = []
      @ccs = []
      @bccs = []
      @subject = nil
      @headers = {}
      @substitutions = {}
      @custom_args = {}
      @dynamic_template_data = {}
      @send_at = nil
    end

    def add_to(to)
      json_to = to.to_json
      unless @tos.include?(json_to) || @ccs.include?(json_to) || @bccs.include?(json_to)
         @tos << json_to
      end
    end

    def add_cc(cc)
      json_cc = cc.to_json
      unless @tos.include?(json_cc) || @ccs.include?(json_cc) || @bccs.include?(json_cc)
        @ccs << json_cc
      end
    end

    def add_bcc(bcc)
      json_bcc = bcc.to_json
      unless @tos.include?(json_bcc) || @ccs.include?(json_bcc) || @bccs.include?(json_bcc)
        @bccs << json_bcc
      end
    end

    def subject=(subject)
      @subject = subject
    end

    def subject
      @subject
    end

    def add_header(header)
      header = header.to_json
      @headers = @headers.merge(header['header'])
    end

    def add_substitution(substitution)
      substitution = substitution.to_json
      @substitutions = @substitutions.merge(substitution['substitution'])
    end

    def add_custom_arg(custom_arg)
      custom_arg = custom_arg.to_json
      @custom_args = @custom_args.merge(custom_arg['custom_arg'])
    end

    def add_dynamic_template_data(dynamic_template_data)
      @dynamic_template_data.merge!(dynamic_template_data)
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
        'dynamic_template_data' => self.dynamic_template_data,
        'send_at' => self.send_at
      }.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
    end
  end
end

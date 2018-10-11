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
      @tos << to.to_json
    end

    def add_cc(cc)
      @ccs << cc.to_json
    end

    def add_bcc(bcc)
      @bccs << bcc.to_json
    end

    attr_writer :subject

    attr_reader :subject

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

    attr_writer :send_at

    attr_reader :send_at

    def to_json(*)
      {
        'to' => tos,
        'cc' => ccs,
        'bcc' => bccs,
        'subject' => subject,
        'headers' => headers,
        'substitutions' => substitutions,
        'custom_args' => custom_args,
        'dynamic_template_data' => dynamic_template_data,
        'send_at' => send_at
      }.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {} }
    end
  end
end

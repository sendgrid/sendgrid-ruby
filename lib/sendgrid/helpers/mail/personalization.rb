require 'json'

module SendGrid
  class Personalization
    attr_reader :tos, :ccs, :bccs, :headers, :substitutions, :custom_args,
                :dynamic_template_data

    attr_accessor :send_at, :subject

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
      raise DuplicatePersonalizationError if duplicate?(to)

      @tos << to.to_json
    end

    def add_cc(cc)
      raise DuplicatePersonalizationError if duplicate?(cc)

      @ccs << cc.to_json
    end

    def add_bcc(bcc)
      raise DuplicatePersonalizationError if duplicate?(bcc)

      @bccs << bcc.to_json
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

    private

    def duplicate?(addition)
      additional_email = addition.email.downcase

      [@tos, @ccs, @bccs].flatten.each do |elm|
        return true if elm&.dig('email')&.downcase == additional_email
      end

      false
    end
  end

  class DuplicatePersonalizationError < StandardError; end
end

require 'json'

module SendGrid
  class Personalization
    include SendGrid::Helpers

    attr_reader :tos, :ccs, :bccs, :headers, :substitutions, :custom_args,
                :dynamic_template_data

    attr_accessor :subject, :send_at

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

    def add_cc(carbon_copy)
      @ccs << carbon_copy.to_json
    end

    def add_bcc(bcc)
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
  end
end

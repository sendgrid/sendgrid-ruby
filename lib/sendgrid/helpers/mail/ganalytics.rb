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

    attr_writer :enable

    attr_reader :enable

    attr_writer :utm_source

    attr_reader :utm_source

    attr_writer :utm_medium

    attr_reader :utm_medium

    attr_writer :utm_term

    attr_reader :utm_term

    attr_writer :utm_content

    attr_reader :utm_content

    attr_writer :utm_campaign

    attr_reader :utm_campaign

    def to_json(*)
      {
        'enable' => enable,
        'utm_source' => utm_source,
        'utm_medium' => utm_medium,
        'utm_term' => utm_term,
        'utm_content' => utm_content,
        'utm_campaign' => utm_campaign
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

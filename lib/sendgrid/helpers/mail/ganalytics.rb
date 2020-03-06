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
end

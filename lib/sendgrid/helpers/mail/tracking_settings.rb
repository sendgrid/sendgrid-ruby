require 'json'

module SendGrid
  class TrackingSettings
    def initialize
      @click_tracking = nil
      @open_tracking = nil
      @subscription_tracking = nil
      @ganalytics = nil
    end

    attr_writer :click_tracking

    def click_tracking
      @click_tracking.nil? ? nil : @click_tracking.to_json
    end

    attr_writer :open_tracking

    def open_tracking
      @open_tracking.nil? ? nil : @open_tracking.to_json
    end

    attr_writer :subscription_tracking

    def subscription_tracking
      @subscription_tracking.nil? ? nil : @subscription_tracking.to_json
    end

    attr_writer :ganalytics

    def ganalytics
      @ganalytics.nil? ? nil : @ganalytics.to_json
    end

    def to_json(*)
      {
        'click_tracking' => click_tracking,
        'open_tracking' => open_tracking,
        'subscription_tracking' => subscription_tracking,
        'ganalytics' => ganalytics
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

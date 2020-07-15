module SendGrid
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
end

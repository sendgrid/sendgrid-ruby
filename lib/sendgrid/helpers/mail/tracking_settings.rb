require 'json'

module SendGrid
  class TrackingSettings

    include SendGrid::Helpers

    attr_writer :click_tracking, :open_tracking, :subscription_tracking, :ganalytics

    def initialize
      @click_tracking = nil
      @open_tracking = nil
      @subscription_tracking = nil
      @ganalytics = nil
    end

    def click_tracking
      @click_tracking.to_json
    end

    def open_tracking
      @open_tracking.to_json
    end

    def subscription_tracking
      @subscription_tracking.to_json
    end

    def ganalytics
      @ganalytics.to_json
    end

  end
end

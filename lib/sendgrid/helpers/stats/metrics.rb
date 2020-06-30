module SendGrid
  class Metrics
    attr_reader :blocks, :bounce_drops,
      :bounces, :clicks, :deferred, :delivered,
      :invalid_emails, :opens, :processed, :requests,
      :spam_report_drops, :spam_reports, :unique_clicks,
      :unique_opens, :unsubscribe_drops, :unsubscribes

    def initialize(args={})
      @date = args['date']
      @blocks = args['blocks']
      @bounce_drops = args['bounce_drops']
      @bounces = args['bounces']
      @clicks = args['clicks']
      @deferred = args['deferred']
      @delivered = args['delivered']
      @invalid_emails = args['invalid_emails']
      @opens = args['opens']
      @processed = args['processed']
      @requests = args['requests']
      @spam_report_drops = args['spam_report_drops']
      @spam_reports = args['spam_reports']
      @unique_clicks = args['unique_clicks']
      @unique_opens = args['unique_opens']
      @unsubscribe_drops = args['unsubscribe_drops']
      @unsubscribes = args['unsubscribes']
    end

    def date
      Date.parse(@date)
    end
  end
end

module SendGrid
  class StatsResponse
    def initialize(args)
      @errors = args['errors'] if args.is_a? Hash
      @stats = args if args.is_a? Array
    end

    def errors
      @errors.map do |error|
        error['message']
      end
    end

    def error?
      !@errors.nil?
    end

    def metrics
      @stats.flat_map do |stat|
        starting_date = stat['date']
        all_stats_for_date = stat['stats']

        all_stats_for_date.map do |metric|
          Metrics.new(metric['metrics'].merge('date' => starting_date))
        end
      end
    end
  end
end

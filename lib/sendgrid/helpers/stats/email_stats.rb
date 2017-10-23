require 'json'

module SendGrid
  class EmailStats
    def initialize(args)
      @sendgrid_client = args[:sendgrid_client]
    end

    def by_day(start_date, end_date, categories = nil, subusers = nil)
      get('day', start_date, end_date, categories, subusers)
    end

    def by_week(start_date, end_date, categories = nil, subusers = nil)
      get('week', start_date, end_date, categories, subusers)
    end

    def by_month(start_date, end_date, categories = nil, subusers = nil)
      get('month', start_date, end_date, categories, subusers)
    end

    def get(aggregated_by, start_date, end_date, categories = nil, subusers = nil)
      params = query_params(aggregated_by, start_date, end_date, categories, subusers)

      response_body = @sendgrid_client.stats.get(query_params: params).body
      build_response(response_body)
    end

    private

    def query_params(aggregated_by, start_date, end_date, categories, subusers)
      params = {
        aggregated_by: aggregated_by,
        start_date: start_date,
        end_date: end_date
      }
      params.merge(categories: categories) if categories
      params.merge(subusers: subusers) if subusers
      params
    end

    def build_response(response_body)
      response_json = JSON.parse(response_body)
      StatsResponse.new(response_json)
    end
  end
end

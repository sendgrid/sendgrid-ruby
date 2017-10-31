require 'spec_helper'

describe SendGrid::EmailStats do
  let(:sg_client) { SendGrid::API.new(api_key: 'abcd').client }
  let(:stats) { SendGrid::EmailStats.new(sendgrid_client: sg_client) }
  let(:sg_response) { double('SendGrid::Response') }

  let(:sample_response) do
    [{
      "date" => "2017-10-01",
      "stats" => [
        {"metrics" =>
          {
            "blocks" => 101,
            "bounce_drops" => 102,
            "bounces" => 103,
            "clicks" => 104,
            "deferred" => 105,
            "delivered" => 106,
            "invalid_emails" => 107,
            "opens" => 108,
            "processed" => 109,
            "requests" => 110,
            "spam_report_drops" => 111,
            "spam_reports" => 112,
            "unique_clicks" => 113,
            "unique_opens" => 114,
            "unsubscribe_drops" => 115,
            "unsubscribes" => 116
          }
        }
      ]
    }]
  end

  let(:error_response) do
    {
      "errors" => [
        {
          "message" => "end_date should be a YYYY-MM-DD formatted date"
        }
      ]
    }
  end

  describe '.new' do
    it 'initializes with SendGrid::Client' do
      expect(stats).to be_a SendGrid::EmailStats
    end
  end

  describe 'successful response' do
    before do
      allow_any_instance_of(SendGrid::Response).to receive(:body) { sample_response.to_json }
    end

    describe '#by_day' do
      it 'fetches data aggregated by day' do
        day_stats = stats.by_day('2017-10-01', '2017-10-02')
        day_metrics = day_stats.metrics.first

        expect(day_metrics).to be_a SendGrid::Metrics
        expect(day_metrics.date.to_s).to eq('2017-10-01')
        expect(day_metrics.requests).to eq(110)
        expect(day_metrics.clicks).to eq(104)
        expect(day_metrics.bounces).to eq(103)
        expect(day_metrics.opens).to eq(108)
      end
    end

    describe '#by_week' do
      it 'fetches data aggregated by week' do
        day_stats = stats.by_week('2017-10-01', '2017-10-12')
        day_metrics = day_stats.metrics.first

        expect(day_metrics).to be_a SendGrid::Metrics
        expect(day_metrics.date.to_s).to eq('2017-10-01')
        expect(day_metrics.requests).to eq(110)
        expect(day_metrics.clicks).to eq(104)
        expect(day_metrics.bounces).to eq(103)
        expect(day_metrics.opens).to eq(108)
      end
    end

    describe '#by_month' do
      it 'fetches data aggregated by month' do
        day_stats = stats.by_month('2017-10-01', '2017-11-01')
        day_metrics = day_stats.metrics.first

        expect(day_metrics).to be_a SendGrid::Metrics
        expect(day_metrics.date.to_s).to eq('2017-10-01')
        expect(day_metrics.requests).to eq(110)
        expect(day_metrics.clicks).to eq(104)
        expect(day_metrics.bounces).to eq(103)
        expect(day_metrics.opens).to eq(108)
      end
    end
  end

  describe 'error response' do
    before do
      allow_any_instance_of(SendGrid::Response).to receive(:body) { error_response.to_json }
    end

    it 'fetches data aggregated by month' do
      day_stats = stats.by_month('2017-10-01', '2017-10-02')

      expect(day_stats.errors).to include('end_date should be a YYYY-MM-DD formatted date')
      expect(day_stats.error?).to be_truthy
    end
  end
end

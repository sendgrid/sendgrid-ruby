require 'spec_helper'

describe SendGrid::StatsResponse do
  let(:params) do
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

  subject { described_class.new(params) }

  it 'initialized with JSON response body' do
    expect(subject).to be_a SendGrid::StatsResponse
  end

  describe '#metrics' do
    it 'returns an array of metrics' do
      metric = subject.metrics.first

      expect(subject.metrics).to be_a Array
      expect(metric.date.to_s).to eq('2017-10-01')
      expect(metric.requests).to eq(110)
      expect(metric.clicks).to eq(104)
      expect(metric.bounces).to eq(103)
      expect(metric.opens).to eq(108)
    end
  end

  context 'errors' do
    let(:error_params) do
      {
        "errors" => [
          {
            "message" => "end_date should be a YYYY-MM-DD formatted date"
          }
        ]
      }
    end

    subject { described_class.new(error_params) }

    describe '#errors' do
      it 'shows a list of errors' do
        expect(subject.errors).to include('end_date should be a YYYY-MM-DD formatted date')
      end
    end

    describe '#error?' do
      it 'returns true if there is an error' do
        expect(subject.error?).to be_truthy
      end
    end
  end
end

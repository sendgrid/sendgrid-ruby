require 'spec_helper'

describe SendGrid::Metrics do
  let(:params) do
    {
      "date" => "2017-10-01",
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
  end

  subject { described_class.new(params) }

  it 'initializes with metric parameters' do
    expect(subject).to be_a SendGrid::Metrics
  end

  it 'returns date as object' do
    expect(subject.date).to be_a Date
  end

  %w(
    blocks bounce_drops bounces clicks deferred delivered invalid_emails
    opens processed requests spam_report_drops spam_reports unique_clicks
    unique_opens unsubscribe_drops unsubscribes
  ).each do |attribute|
    it "responds to #{attribute}" do
      expect(subject).to respond_to(attribute.to_sym)
    end
  end

end

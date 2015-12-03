require 'json'
require 'spec_helper'
require 'webmock/rspec'

describe 'MarketingCampaigns::Client' do
  it 'should accept an api key' do
    expect(MarketingCampaigns::Client.new(api_key: 'sendgrid_123')).to be_an_instance_of(MarketingCampaigns::Client)
  end

  it 'should build the default url' do
    expect(MarketingCampaigns::Client.new.url).to eq('https://api.sendgrid.com')
  end

  it 'should build a custom url' do
    expect(MarketingCampaigns::Client.new(port: 3000, host: 'foo.sendgrid.com', protocol: 'tacos').url).to eq('tacos://foo.sendgrid.com:3000')
  end

  it 'should use the default endpoint' do
    expect(MarketingCampaigns::Client.new.endpoint).to eq('/v3/campaigns')
  end

  it 'accepts a block' do
    expect { |b| MarketingCampaigns::Client.new(&b) }.to yield_control
  end

  it 'should have an auth header when using an api key' do
    stub_request(:any, 'https://api.sendgrid.com/v3/campaigns')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

    client = MarketingCampaigns::Client.new(api_key: 'abc123')
    mail = MarketingCampaigns::Campaign.new(title: 'test title')

    client.create(mail)

    expect(WebMock).to have_requested(:post, 'https://api.sendgrid.com/v3/campaigns')
                           .with(headers: {'Authorization' => 'Bearer abc123'})
  end

  describe ':create' do
    it 'should return campaign data on success' do
      stub_request(:post, 'https://api.sendgrid.com/v3/campaigns')
          .to_return(body: {id: 123, title: "Untitled"}.to_json, status: 201, headers: {'X-TEST' => 'yes'})

      client = MarketingCampaigns::Client.new(api_key: 'abc123')
      mail = MarketingCampaigns::Campaign.new(title: 'test title')
      res = client.create(mail)
      expect(res.code).to eq(201)
      expect(res.body['id']).to eq(123)
      expect(res.body['title']).to eq('Untitled')
    end
  end

  describe ':get' do
    it 'should return campaign data on success' do
      stub_request(:get, 'https://api.sendgrid.com/v3/campaigns/123')
          .to_return(body: {id: 123, title: "Untitled"}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      client = MarketingCampaigns::Client.new(api_key: 'abc123')
      res = client.get(123)
      expect(res.code).to eq(200)
      expect(res.body['id']).to eq(123)
      expect(res.body['title']).to eq('Untitled')
    end
  end

  describe ':delete' do
    it 'should return 204 on success' do
      stub_request(:delete, 'https://api.sendgrid.com/v3/campaigns/123')
          .to_return(status: 204, headers: {'X-TEST' => 'yes'})

      client = MarketingCampaigns::Client.new(api_key: 'abc123')
      res = client.delete(123)
      expect(res.code).to eq(204)
      expect(res.body).to eq(nil)
    end

    it 'should return 404 for a non found campaign' do
      stub_request(:delete, 'https://api.sendgrid.com/v3/campaigns/123')
          .to_return(body: {errors: [message: 'not found']}.to_json, status: 404, headers: {'X-TEST' => 'yes'})

      client = MarketingCampaigns::Client.new(api_key: 'abc123')
      res = client.delete(123)
      expect(res.code).to eq(404)
      expect(res.body['errors'][0]['message']).to eq('not found')
    end
  end

end

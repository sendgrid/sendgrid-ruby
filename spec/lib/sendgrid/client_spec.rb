require 'spec_helper'

describe 'SendGrid::Client' do
  it 'should accept a username and password' do
    expect(SendGrid::Client.new(api_user: 'test', api_key: 'test')).to be_an_instance_of(SendGrid::Client)
  end

  it 'should accept an api key' do
    expect(SendGrid::Client.new(api_key: 'sendgrid_123')).to be_an_instance_of(SendGrid::Client)
  end

  it 'should build the default url' do
    expect(SendGrid::Client.new.url).to eq('https://api.sendgrid.com')
  end

  it 'should build a custom url' do
    expect(SendGrid::Client.new(port: 3000, host: 'foo.sendgrid.com', protocol: 'tacos').url).to eq('tacos://foo.sendgrid.com:3000')
  end

  it 'should use the default endpoint' do
    expect(SendGrid::Client.new.endpoint).to eq('/api/mail.send.json')
  end

  # it 'should send' do
    # stub_request(:any, "www.example.com").
       # to_return(body: "abc", status: 200, headers: { 'Content-Length' => 3 })
    # res = RestClient.get("www.example.com")
    # expect(res.code).to eq(200)
  # end

  # describe ':send' do
    # it 'should accept a mail' do
      # create_client
      # m = SendGrid::Mail.new
      # @client.send(m)
    # end
  # end
end

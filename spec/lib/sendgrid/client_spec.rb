require 'json'
require 'spec_helper'
require 'webmock/rspec'

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

  it 'accepts a block' do
    expect { |b| SendGrid::Client.new(&b) }.to yield_control
  end

  describe ':send' do
    it 'should make a request to sendgrid' do
      stub_request(:any, 'https://api.sendgrid.com/api/mail.send.json')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      client = SendGrid::Client.new(api_key: 'abc123')
      mail = SendGrid::Mail.new
      res = client.send(mail)
      expect(res.code).to eq(200)
    end

    it 'should have the proper payload' do
      stub_request(:any, 'https://api.sendgrid.com/api/mail.send.json')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      client = SendGrid::Client.new(api_key: 'abc123')
      mail = SendGrid::Mail.new(to: 'test', content: 'hello world.')
      client.send(mail)

      expect(WebMock).to have_requested(:post, 'https://api.sendgrid.com/api/mail.send.json')
        .with(body: mail.to_h)
    end
  end

  describe ':post' do
    let(:token_client) { SendGrid::Client.new(api_key: 'abc123') }
    let(:user_client)  { SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123') }

    it 'should make a post request to sendgrid' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.post('/api/test')

      expect(WebMock).to have_requested(:post, 'https://api.sendgrid.com/api/test')
    end

    it 'should make a request with the specified payload' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.post('/api/test', { am_i_here: true } )

      expect(WebMock).to have_requested(:post, 'https://api.sendgrid.com/api/test')
        .with(body: 'am_i_here=true')
    end

    it 'should have an auth header when using an api key' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.post('/api/test')

      expect(WebMock).to have_requested(:post, 'https://api.sendgrid.com/api/test')
        .with(headers: {'Authorization' => 'Bearer abc123'})
    end

    it 'should have a username + password when using them' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      user_client.post('/api/test')

      expect(WebMock).to have_requested(:post, 'https://api.sendgrid.com/api/test')
        .with(body: 'api_key=abc123&api_user=foobar')
    end

    it 'should raise a SendGrid::Exception if status is not 200' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      expect { user_client.post('/api/test') }.to raise_error(SendGrid::Exception)
    end

    it 'should not raise a SendGrid::Exception if raise_exceptions is disabled' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      client = SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123', raise_exceptions: false)

      expect { client.post('/api/test') }.not_to raise_error
    end
  end

  describe ':patch' do
    let(:token_client) { SendGrid::Client.new(api_key: 'abc123') }
    let(:user_client)  { SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123') }

    it 'should make a post request to sendgrid' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.patch('/api/test')

      expect(WebMock).to have_requested(:patch, 'https://api.sendgrid.com/api/test')
    end

    it 'should make a request with the specified payload' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.patch('/api/test', { am_i_here: true } )

      expect(WebMock).to have_requested(:patch, 'https://api.sendgrid.com/api/test')
        .with(body: 'am_i_here=true')
    end

    it 'should have an auth header when using an api key' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.patch('/api/test')

      expect(WebMock).to have_requested(:patch, 'https://api.sendgrid.com/api/test')
        .with(headers: {'Authorization' => 'Bearer abc123'})
    end

    it 'should have a username + password when using them' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      user_client.patch('/api/test')

      expect(WebMock).to have_requested(:patch, 'https://api.sendgrid.com/api/test')
        .with(body: 'api_key=abc123&api_user=foobar')
    end

    it 'should raise a SendGrid::Exception if status is not 200' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      expect { user_client.patch('/api/test') }.to raise_error(SendGrid::Exception)
    end

    it 'should not raise a SendGrid::Exception if raise_exceptions is disabled' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      client = SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123', raise_exceptions: false)

      expect { client.patch('/api/test') }.not_to raise_error
    end
  end

  describe ':get' do
    let(:token_client) { SendGrid::Client.new(api_key: 'abc123') }
    let(:user_client)  { SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123') }

    it 'should make a post request to sendgrid' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.get('/api/test')

      expect(WebMock).to have_requested(:get, 'https://api.sendgrid.com/api/test')
    end

    it 'should make a request with the specified payload' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.get('/api/test', { am_i_here: true } )

      expect(WebMock).to have_requested(:get, 'https://api.sendgrid.com/api/test')
        .with(body: 'am_i_here=true')
    end

    it 'should have an auth header when using an api key' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.get('/api/test')

      expect(WebMock).to have_requested(:get, 'https://api.sendgrid.com/api/test')
        .with(headers: {'Authorization' => 'Bearer abc123'})
    end

    it 'should have a username + password when using them' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      user_client.get('/api/test')

      expect(WebMock).to have_requested(:get, 'https://api.sendgrid.com/api/test')
        .with(body: 'api_key=abc123&api_user=foobar')
    end

    it 'should raise a SendGrid::Exception if status is not 200' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      expect { user_client.get('/api/test') }.to raise_error(SendGrid::Exception)
    end

    it 'should not raise a SendGrid::Exception if raise_exceptions is disabled' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      client = SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123', raise_exceptions: false)

      expect { client.get('/api/test') }.not_to raise_error
    end
  end

  describe ':get' do
    let(:token_client) { SendGrid::Client.new(api_key: 'abc123') }
    let(:user_client)  { SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123') }

    it 'should make a post request to sendgrid' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.delete('/api/test')

      expect(WebMock).to have_requested(:delete, 'https://api.sendgrid.com/api/test')
    end

    it 'should have an auth header when using an api key' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      token_client.delete('/api/test')

      expect(WebMock).to have_requested(:delete, 'https://api.sendgrid.com/api/test')
        .with(headers: {'Authorization' => 'Bearer abc123'})
    end

    it 'should have a username + password when using them' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      user_client.delete('/api/test')

      expect(WebMock).to have_requested(:delete, 'https://api.sendgrid.com/api/test')
        .with(headers: { 'Authorization' => 'Basic Zm9vYmFyOmFiYzEyMw==' } )
    end

    it 'should raise a SendGrid::Exception if status is not 200' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      expect { user_client.delete('/api/test') }.to raise_error(SendGrid::Exception)
    end

    it 'should not raise a SendGrid::Exception if raise_exceptions is disabled' do
      stub_request(:any, 'https://api.sendgrid.com/api/test')
        .to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})

      client = SendGrid::Client.new(api_user: 'foobar', api_key: 'abc123', raise_exceptions: false)

      expect { client.delete('/api/test') }.not_to raise_error
    end
  end
end

require 'json'
require 'spec_helper'
require 'webmock/rspec'

describe 'SendGrid::Client' do
  let(:api_key){ 'abc123' }
  let(:client) { SendGrid::Client.new(api_key: api_key) }
  let(:body){ {'message' => 'success'} }
  let(:status){ 200 }
  let(:path){ '/api/some_endpoint' }
  let(:response){ {body: body.to_json, status: status, headers: {'X-TEST' => 'yes'}} }

  before do
    stub_request(:any, "https://api.sendgrid.com#{path}")
    .to_return(response)
  end

  describe '.new' do
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
  end

  shared_examples_for "a request" do |method|
    let(:api_user) { 'foobar' }

    it 'should make a request to sendgrid' do
      res = perform_action(client)
      expect(res.code).to eq(200)
    end

    it "should return a response object with the body" do
      res = perform_action(client)
      expect(res.body).to eq(body)
    end

    context "when using an api key" do
      it 'should have an auth header' do
        perform_action(client)

        expect(WebMock).to have_requested(method, "https://api.sendgrid.com#{path}")
          .with(headers: {'Authorization' => "Bearer #{api_key}"})
      end
    end

    context "when using username + password" do
      it 'should have them in the body' do
        client = SendGrid::Client.new(api_user: api_user, api_key: api_key)
        perform_action(client)

        expect(WebMock).to have_requested(method, "https://api.sendgrid.com#{path}")
          .with(body: %r{api_key=#{api_key}&api_user=#{api_user}})
      end
    end

    context "when an error occurs" do
      let(:status) { 400 }

      it 'should raise a SendGrid::Exception if status is not 200' do
        expect {perform_action(client)}.to raise_error(SendGrid::Exception)
      end

      it 'should not raise a SendGrid::Exception if raise_exceptions is disabled' do
        client = SendGrid::Client.new(api_user: api_user, api_key: api_key, raise_exceptions: false)

        expect {perform_action(client)}.not_to raise_error
      end
    end
  end

  describe "#get" do
    it_behaves_like "a request", :get do
      def perform_action(client)
        client.get(path)
      end
    end
  end

  describe "#post" do
    it_behaves_like "a request", :post do
      let(:post_data){ {name: 'Bob'} }

      def perform_action(client)
        client.post(path, post_data)
      end

      it 'should include the data in the request body' do
        perform_action(client)
        expect(WebMock).to have_requested(:post, "https://api.sendgrid.com#{path}")
          .with(body: %r{name=Bob})
      end
    end
  end

  describe '#send' do
    let(:path){ '/api/mail.send.json' }

    it "should send a POST request to the /api/mail.send.json endpoint" do
      mail = SendGrid::Mail.new
      client.send(mail)
      expect(WebMock).to have_requested(:post, "https://api.sendgrid.com#{path}")
    end

    it "includes the email in the request body" do
      mail = SendGrid::Mail.new
      mail_hash = {subject: 'foobar'}
      allow(mail).to receive(:to_h).and_return(mail_hash)
      client.send(mail)
      expect(WebMock).to have_requested(:post, "https://api.sendgrid.com#{path}").
        with(body: %r{subject=foobar})
    end
  end

end

require 'json'
require 'spec_helper'
require 'webmock/rspec'

describe 'SendGrid::ScheduledSend' do
  let(:params) { { api_user: 'foo', api_key: 'abc123' } }
  let(:scheduled_send_api) { SendGrid::ScheduledSend.new(api_user: 'foo', api_key: 'abc123') }
  
  it 'should initialize a client' do
    scheduled_send_api = SendGrid::ScheduledSend.new(params)
    expect(scheduled_send_api.client).to be_an_instance_of(SendGrid::Client)
  end
  
  it 'requires a username and password' do
    expect { SendGrid::ScheduledSend.new(api_key: 'abc123') }
      .to raise_error(SendGrid::Exception)
  end
  
  describe ':client' do
    it 'should be an instance of SendGrid::Client' do
      expect(scheduled_send_api.client).to be_an_instance_of(SendGrid::Client)
    end
    
    it 'fails when not an instance of SendGrid::Client' do
      scheduled_send_api.instance_variable_set(:@client, Object.new)
      expect { scheduled_send_api.client }.to raise_error(SendGrid::Exception)
    end
  end
  
  describe ':generate_batch_id' do
    it 'makes a post request to the schedule send api' do
      url = 'https://api.sendgrid.com/v3/mail/batch'
      
      stub_request(:post, url)
      
      scheduled_send_api.generate_batch_id
      
      expect(WebMock).to have_requested(:post, url).with(body: params)
    end
  end
  
  describe ':validate_batch_id' do
    it 'makes a get request to the schedule send api' do
      batch_id = '1234abcd'
      url = "https://api.sendgrid.com/v3/mail/batch/#{batch_id}"
      
      stub_request(:any, url)
      
      scheduled_send_api.validate_batch_id(batch_id)
      
      expect(WebMock).to have_requested(:get, url).with(body: params)
    end
  end
  
  describe ':scheduled_send' do
    it 'makes a get request to the schedule send api' do
      batch_id = '1234abcd'
      url = "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}"
      
      stub_request(:any, url)
        
      scheduled_send_api.scheduled_send(batch_id)
      
      expect(WebMock).to have_requested(:get, url).with(body: params)
    end
  end
  
  describe ':scheduled_sends' do
    it 'makes a get request to the schedule send api' do
      url = "https://api.sendgrid.com/v3/user/scheduled_sends"
      
      stub_request(:any, url)
        
      scheduled_send_api.scheduled_sends
      
      expect(WebMock).to have_requested(:get, url).with(body: params)
    end
  end
  
  describe ':cancel_scheduled_send' do
    context 'when previously updated' do
      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return([1])
      end
      
      it 'makes a patch request to the schedule send api' do
        batch_id = '1234abcd'
        url = "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}"
        
        stub_request(:any, url)
          
        scheduled_send_api.cancel_scheduled_send(batch_id)
        
        expect(WebMock).to have_requested(:patch, url)
          .with(body: params.merge(status: 'cancel'))
      end
    end
    
    context 'when cancelled for the first time' do
      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return([])
      end
      
      it 'makes a post request to the schedule send api' do
        batch_id = '1234abcd'
        url = "https://api.sendgrid.com/v3/user/scheduled_sends"
        
        stub_request(:any, url)
          
        scheduled_send_api.cancel_scheduled_send(batch_id)
        
        expect(WebMock).to have_requested(:post, url)
          .with(body: params.merge(batch_id: batch_id, status: 'cancel'))
      end
    end
  end
  
  describe ':pause_scheduled_send' do
    context 'when previously updated' do
      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return([1])
      end
      
      it 'makes a patch request to the schedule send api' do
        batch_id = '1234abcd'
        url = "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}"
        
        stub_request(:any, url)
          
        scheduled_send_api.pause_scheduled_send(batch_id)
        
        expect(WebMock).to have_requested(:patch, url)
          .with(body: params.merge(status: 'pause'))
      end
    end
    
    context 'when cancelled for the first time' do
      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return([])
      end
      
      it 'makes a post request to the schedule send api' do
        batch_id = '1234abcd'
        url = "https://api.sendgrid.com/v3/user/scheduled_sends"
        
        stub_request(:any, url)
          
        scheduled_send_api.pause_scheduled_send(batch_id)
        
        expect(WebMock).to have_requested(:post, url)
          .with(body: params.merge(batch_id: batch_id, status: 'pause'))
      end
    end
  end
end
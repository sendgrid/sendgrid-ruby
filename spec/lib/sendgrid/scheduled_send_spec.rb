require 'json'
require 'spec_helper'
require 'webmock/rspec'

describe 'SendGrid::ScheduledSend' do
  let(:batch_id) { '1234abcd' }
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
    let(:url) { 'https://api.sendgrid.com/v3/mail/batch' }

    it 'makes a post request to the schedule send api' do
      stub_request(:any, url)

      scheduled_send_api.generate_batch_id

      expect(WebMock).to have_requested(:post, url).with(body: params)
    end

    it 'returns the batch id when successful' do
      body = { batch_id: batch_id }
      stub_request(:any, url).to_return(status: 201, body: body.to_json)

      expect(scheduled_send_api.generate_batch_id).to eq batch_id
    end
  end

  describe ':validate_batch_id' do
    let(:url) { "https://api.sendgrid.com/v3/mail/batch/#{batch_id}" }

    it 'makes a get request to the schedule send api' do
      stub_request(:any, url)

      scheduled_send_api.validate_batch_id(batch_id)

      expect(WebMock).to have_requested(:get, url).with(body: params)
    end

    it 'returns the batch id when valid' do
      body = { batch_id: batch_id }
      stub_request(:any, url).to_return(status: 200, body: body.to_json)

      expect(scheduled_send_api.validate_batch_id(batch_id)).to eq batch_id
    end

    it 'raises an error when invalid' do
      stub_request(:any, url).to_return(status: 400)

      expect { scheduled_send_api.validate_batch_id(batch_id) }
        .to raise_error(SendGrid::Exception)
    end
  end

  describe ':scheduled_send' do
    let(:url) { "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}" }

    it 'makes a get request to the schedule send api' do
      stub_request(:any, url)

      scheduled_send_api.scheduled_send(batch_id)

      expect(WebMock).to have_requested(:get, url).with(body: params)
    end

    it 'returns the scheduled send when cancelled' do
      body = { "batch_id" => batch_id, "status" => "cancel" }
      stub_request(:any, url).to_return(status: 200, body: [body].to_json)

      expect(scheduled_send_api.scheduled_send(batch_id)).to eq body
    end

    it 'returns the scheduled send when paused' do
      body = { "batch_id" => batch_id, "status" => "cancel" }
      stub_request(:any, url).to_return(status: 200, body: [body].to_json)

      expect(scheduled_send_api.scheduled_send(batch_id)).to eq body
    end

    it 'returns nil when not cancelled or paused' do
      stub_request(:any, url).to_return(status: 200, body: [].to_json)

      expect(scheduled_send_api.scheduled_send(batch_id)).to be nil
    end
  end

  describe ':scheduled_sends' do
    let(:url) { "https://api.sendgrid.com/v3/user/scheduled_sends" }

    it 'makes a get request to the schedule send api' do
      stub_request(:any, url)

      scheduled_send_api.scheduled_sends

      expect(WebMock).to have_requested(:get, url).with(body: params)
    end

    it 'returns the scheduled sends' do
      body = [
        { "batch_id" => batch_id, "status" => "cancel" },
        { "batch_id" => "#{batch_id}1234", "status" => "pause" }
      ]
      stub_request(:any, url).to_return(status: 200, body: body.to_json)

      expect(scheduled_send_api.scheduled_sends).to eq body
    end

    it 'is empty when there are no scheduled sends' do
      stub_request(:any, url).to_return(status: 200, body: [].to_json)

      expect(scheduled_send_api.scheduled_sends).to be_empty
    end
  end

  describe ':cancel_scheduled_send' do
    context 'when previously updated' do
      let(:url)  { "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}" }
      let(:body) { params.merge(status: 'cancel') }

      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return([1])
      end

      it 'makes a patch request to the schedule send api' do
        stub_request(:any, url)

        scheduled_send_api.cancel_scheduled_send(batch_id)

        expect(WebMock).to have_requested(:patch, url).with(body: body)
      end

      it 'returns the status when successful' do
        body = { "status" => "cancel" }
        stub_request(:any, url).to_return(status: 201, body: body.to_json)

        expect(scheduled_send_api.cancel_scheduled_send(batch_id)).to eq body
      end

      it 'raises an error when unsuccessful' do
        stub_request(:any, url).to_return(status: 400)

        expect { scheduled_send_api.cancel_scheduled_send(batch_id) }
          .to raise_error(SendGrid::Exception)
      end
    end

    context 'when cancelled for the first time' do
      let(:url)  { "https://api.sendgrid.com/v3/user/scheduled_sends" }
      let(:body) { params.merge(batch_id: batch_id, status: 'cancel') }

      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return(nil)
      end

      it 'makes a post request to the schedule send api' do
        stub_request(:any, url)

        scheduled_send_api.cancel_scheduled_send(batch_id)

        expect(WebMock).to have_requested(:post, url).with(body: body)
      end

      it 'raises an error when unsuccessful' do
        stub_request(:any, url).to_return(status: 400)

        expect { scheduled_send_api.cancel_scheduled_send(batch_id) }
          .to raise_error(SendGrid::Exception)
      end
    end
  end

  describe ':pause_scheduled_send' do
    context 'when previously updated' do
      let(:url)  { "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}" }
      let(:body) { params.merge(status: 'pause') }

      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return([1])
      end

      it 'makes a patch request to the schedule send api' do
        stub_request(:any, url)

        scheduled_send_api.pause_scheduled_send(batch_id)

        expect(WebMock).to have_requested(:patch, url).with(body: body)
      end

      it 'raises an error when unsuccessful' do
        stub_request(:any, url).to_return(status: 400)

        expect { scheduled_send_api.pause_scheduled_send(batch_id) }
          .to raise_error(SendGrid::Exception)
      end
    end

    context 'when cancelled for the first time' do
      let(:url)  { "https://api.sendgrid.com/v3/user/scheduled_sends" }
      let(:body) { params.merge(batch_id: batch_id, status: 'pause') }

      before do
        allow(scheduled_send_api).to receive(:scheduled_send).and_return(nil)
      end

      it 'makes a post request to the schedule send api' do
        stub_request(:any, url)

        scheduled_send_api.pause_scheduled_send(batch_id)

        expect(WebMock).to have_requested(:post, url).with(body: body)
      end

      it 'raises an error when unsuccessful' do
        stub_request(:any, url).to_return(status: 400)

        expect { scheduled_send_api.pause_scheduled_send(batch_id) }
          .to raise_error(SendGrid::Exception)
      end
    end
  end

  describe ':resume_scheduled_send' do
    let(:url) { "https://api.sendgrid.com/v3/user/scheduled_sends/#{batch_id}" }

    it 'makes a request to the scheduled send api' do
      stub_request(:any, url)

      scheduled_send_api.resume_scheduled_send(batch_id)

      expect(WebMock).to have_requested(:delete, url)
    end

    it 'is successful for a valid batch id' do
      stub_request(:any, url).to_return(status: 204, body: "")

      expect(scheduled_send_api.resume_scheduled_send(batch_id)).to be_empty
    end

    it 'is raises an error for an invalid batch id' do
      stub_request(:any, url).to_return(status: 404)

      expect { scheduled_send_api.resume_scheduled_send(batch_id) }
        .to raise_error(SendGrid::Exception)
    end
  end
end
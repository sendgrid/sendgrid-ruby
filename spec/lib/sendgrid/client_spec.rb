require_relative '../../../lib/sendgrid-ruby'

module SendGrid
  describe Client do
    describe '#initialize' do
      let(:params) do
        {
          api_user: api_user,
          api_key: api_key,
          host: host,
          endpoint: endpoint,
          conn: conn,
          user_agent: user_agent,
        }.reject { |_, v| v.nil? }
      end

      let(:api_user) { anything }
      let(:api_key) { anything }
      let(:host) { anything }
      let(:endpoint) { anything }
      let(:conn) { anything }
      let(:user_agent) { anything }

      subject { described_class.new(params) }

      context 'all required parameters are present' do
        it 'sets instance variables' do
          expect(subject.instance_variable_get(:@api_user)).to_not be_nil
          expect(subject.instance_variable_get(:@api_key)).to_not be_nil
          expect(subject.instance_variable_get(:@host)).to_not be_nil
          expect(subject.instance_variable_get(:@endpoint)).to_not be_nil
          expect(subject.instance_variable_get(:@conn)).to_not be_nil
          expect(subject.instance_variable_get(:@user_agent)).to_not be_nil
        end
      end

      context 'conn is nil' do
        let(:conn) { nil }

        it 'calls out to establish one' do
          expect_any_instance_of(described_class).to receive(:create_conn).once
          subject
        end
      end

      context 'host is nil' do
        let(:host) { nil }

        it 'sets the host to a default' do
          expect(subject.instance_variable_get(:@host)).to eq('https://api.sendgrid.com')
        end
      end

      context 'endpoint is nil' do
        let(:endpoint) { nil }

        it 'sets the host to a default' do
          expect(subject.instance_variable_get(:@endpoint)).to eq('/api/mail.send.json')
        end
      end

      context 'user_agent is nil' do
        let(:user_agent) { nil }

        it 'sets the host to a default' do
          expect(subject.instance_variable_get(:@user_agent)).to eq('sendgrid/' + SendGrid::VERSION + ';ruby')
        end
      end

      context 'api_key or api_user is nil' do
        context 'api_key is nil' do
          let(:api_key) { nil }

          it { expect { subject }.to raise_error(SendGrid::Exception, 'api_user and api_key are required') }
        end

        context 'api_user is nil' do
          let(:api_user) { nil }

          it { expect { subject }.to raise_error(SendGrid::Exception, 'api_user and api_key are required') }
        end

        context 'both are nil' do
          let(:api_key) { nil }
          let(:api_user) { nil }

          it { expect { subject }.to raise_error(SendGrid::Exception, 'api_user and api_key are required') }
        end
      end

      context 'a block is given' do
        it 'yields' do
          expect { |b| described_class.new(params, &b) }.to yield_control
        end
      end
    end

    describe '#send' do
      let(:api_key) { anything }
      let(:api_user) { anything }

      subject { described_class.new(api_key: api_key, api_user: api_user) }

      let(:mail) { Mail.new }
      let(:mail_hash) { {} }

      before do
        allow(mail).to receive(:to_h) { mail_hash }
      end

      it 'merges api_user and api_key into the mail hash' do
        allow_any_instance_of(RestClient::Resource).to receive(:post)

        expect(mail_hash).to receive(:merge).with({ api_key: api_key, api_user: api_user })
        subject.send(mail)
      end

      it 'calls out to RestClient::Resource' do
        payload = mail_hash.merge(api_user: api_user, api_key: api_key)
        expect_any_instance_of(RestClient::Resource).to receive(:post).with(payload, hash_including(:user_agent))
        subject.send(mail)
      end

      describe 'responses' do
        let(:response) { Object.new }
        let(:request) { anything }
        let(:result) { anything }

        before do
          allow(response).to receive(:code) { response_code }
          allow_any_instance_of(RestClient::Resource).to receive(:post).and_yield(response, request, result)
        end

        context '200 response' do
          let(:response_code) { 200 }

          it 'returns the response' do
            expect(subject.send(mail)).to eq(response)
          end
        end

        context '400 response' do
          let(:response_code) { 400 }

          it 'creates a new exception' do
            expect { subject.send(mail) }.to raise_error(SendGrid::Exception)
          end
        end

        context '500 response' do
          let(:response_code) { 500 }

          it 'creates a new exception' do
            expect { subject.send(mail) }.to raise_error(SendGrid::Exception)
          end
        end
      end
    end
  end
end

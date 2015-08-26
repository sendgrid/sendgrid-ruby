require_relative '../../../lib/sendgrid/mail'

module SendGrid
  describe Mail do
    describe '#initialize' do
      let(:params) do
        {
          to: anything,
          to_name: anything,
          from: anything,
          from_name: anything,
          subject: anything,
          text: anything,
          html: anything,
          cc: anything,
          bcc: anything,
          reply_to: anything,
          date: anything,
          smtpapi: anything,
          attachments: anything,
        }
      end

      subject { described_class.new(params) }

      it 'sets instance variables' do
        expect(subject.instance_variable_get(:@to)).to_not be_nil
        expect(subject.instance_variable_get(:@to_name)).to_not be_nil
        expect(subject.instance_variable_get(:@from)).to_not be_nil
        expect(subject.instance_variable_get(:@from_name)).to_not be_nil
        expect(subject.instance_variable_get(:@subject)).to_not be_nil
        expect(subject.instance_variable_get(:@text)).to_not be_nil
        expect(subject.instance_variable_get(:@html)).to_not be_nil
        expect(subject.instance_variable_get(:@cc)).to_not be_nil
        expect(subject.instance_variable_get(:@bcc)).to_not be_nil
        expect(subject.instance_variable_get(:@reply_to)).to_not be_nil
        expect(subject.instance_variable_get(:@date)).to_not be_nil
        expect(subject.instance_variable_get(:@smtpapi)).to_not be_nil
        expect(subject.instance_variable_get(:@attachments)).to_not be_nil
        expect(subject.instance_variable_get(:@headers)).to_not be_nil
      end

      describe 'headers' do
        context 'they are passed in' do
          subject { described_class.new(params.merge(headers: { foo: :bar })) }

          it 'does not initalize with an empty hash' do
            instance_headers = subject.instance_variable_get(:@headers)
            expect(instance_headers).to_not eq({})
          end
        end

        context 'they are not passed in' do
          it 'initializes an empty hash' do
            instance_headers = subject.instance_variable_get(:@headers)
            expect(instance_headers).to eq({})
          end
        end
      end

      describe 'attachments' do
        context 'they are passed in' do
          subject { described_class.new(params.merge(attachments: { foo: :bar })) }

          it 'does not initalize with an empty hash' do
            instance_attachments = subject.instance_variable_get(:@attachments)
            expect(instance_attachments).to_not eq({})
          end
        end

        context 'they are not passed in' do
          it 'initializes an empty hash' do
            instance_attachments = subject.instance_variable_get(:@attachments)
            expect(instance_attachments).to eq(anything)
          end
        end
      end

      describe 'smtpapi' do
        context 'a smtpapi was passed in' do
          subject { described_class.new(params.merge(smtpapi: Object.new)) }

          it 'does not initalize with a new object' do
            instance_smtpapi = subject.instance_variable_get(:@smtpapi)
            expect(instance_smtpapi).to_not be_a(Smtpapi::Header)
          end
        end

        context 'a smtpapi was not passed in' do
          subject { described_class.new(params.reject { |k, _| k == :smtpapi } ) }

          it 'initializes a new Smtpapi::Header object' do
            instance_smtpapi = subject.instance_variable_get(:@smtpapi)
            expect(instance_smtpapi).to be_a(Smtpapi::Header)
          end
        end
      end

      context 'a block is given' do
        it 'yields to the block' do
          expect { |b| described_class.new(params, &b) }.to yield_control
        end
      end
    end

    describe '#add_to' do
      let(:to_email) { 'anything@example.com' }

      it 'calls add_to on the smtpapi' do
        expect_any_instance_of(Smtpapi::Header).to receive(:add_to).with(to_email)
        subject.add_to(to_email)
      end
    end

    describe '#add_attachment' do
      let(:attachment_path) { '/some/file/path' }

      before do
        allow(File).to receive(:new).with(attachment_path) { anything }
        allow(File).to receive(:basename) { anything }
      end

      it 'adds the file to the attachments list' do
        expect do
          subject.add_attachment(attachment_path)
        end.to change { subject.attachments }
      end
    end

    describe '#to_h' do
      let(:attachments) { [{ name: 'some filename', file: anything }] }
      let(:params) do
        {
          to: anything,
          to_name: anything,
          from: anything,
          from_name: anything,
          subject: anything,
          text: anything,
          html: anything,
          cc: anything,
          bcc: anything,
          reply_to: anything,
          date: anything,
          smtpapi: anything,
          attachments: attachments,
        }
      end

      subject { described_class.new(params) }

      context 'with all fields populated' do
        it 'returns all fields in the response' do
          payload = subject.to_h
          expect(payload).to have_key(:from)
          expect(payload).to have_key(:fromname)
          expect(payload).to have_key(:subject)
          expect(payload).to have_key(:to)
          expect(payload).to have_key(:toname)
          expect(payload).to have_key(:date)
          expect(payload).to have_key(:replyto)
          expect(payload).to have_key(:cc)
          expect(payload).to have_key(:bcc)
          expect(payload).to have_key(:text)
          expect(payload).to have_key(:html)
          expect(payload).to have_key(:'x-smtpapi')
          expect(payload).to have_key(:files)
        end
      end

      context 'with nil fields' do
        let(:params) do
          {
            to: anything,
            to_name: anything,
            from: anything,
            from_name: anything,
            subject: anything,
            text: anything,
            html: anything,
            reply_to: anything,
            date: anything,
            smtpapi: anything,
            attachments: attachments,
          }
        end

        it 'does not include them in the response' do
          payload = subject.to_h
          expect(payload).to have_key(:from)
          expect(payload).to have_key(:fromname)
          expect(payload).to have_key(:subject)
          expect(payload).to have_key(:to)
          expect(payload).to have_key(:toname)
          expect(payload).to have_key(:date)
          expect(payload).to have_key(:replyto)
          expect(payload).to_not have_key(:cc)
          expect(payload).to_not have_key(:bcc)
          expect(payload).to have_key(:text)
          expect(payload).to have_key(:html)
          expect(payload).to have_key(:'x-smtpapi')
          expect(payload).to have_key(:files)
        end
      end

      describe 'attachments' do
        it 'restructures the hash to sit under a files key' do
          payload = subject.to_h
          expect(payload[:files]).to eq(attachments.first[:name] => attachments.first[:file])
        end

        context 'attachments is an empty array' do
          let(:attachments) { [] }
          it 'does not include files' do
            expect(subject.to_h).to_not have_key(:files)
          end
        end
      end

      describe 'to' do
        context 'the to is nil and the smtpapi to is not nil' do
          before do
            allow_any_instance_of(Smtpapi::Header).to receive(:to) { [anything] }
          end

          subject { described_class.new(params.reject { |k, _| k == :to || k == :smtpapi }) }

          it 'sets the to address to from' do
            payload = subject.to_h
            expect(payload[:to]).to eq(params[:from])
          end
        end
      end
    end
  end
end

require_relative '../../../lib/sendgrid/template'

module SendGrid
  describe Template do
    let(:id) { anything }
    subject { described_class.new(id) }

    describe '#initialize' do
      it 'sets the id instance var' do
        expect(subject.instance_variable_get(:@id)).to_not be_nil
      end
      it 'cache_recipients instance variable defaults to true' do
        expect(subject.instance_variable_get(:@cache_recipients)).to be_truthy
      end
      context 'cache_recipients: false' do
        subject { described_class.new(id, cache_recipients: false) }

        it 'sets cache_recipients instance varialbe to false' do
          expect(subject.instance_variable_get(:@cache_recipients)).to be_falsey
        end
      end
    end

    describe '#add_recipient' do
      let(:first_recipient) { Recipient.new('someone@anything.com') }
      let(:second_recipient) { Recipient.new('test@test.com') }
      let(:recipients) { [first_recipient, second_recipient] }

      context 'cache_recipients: true' do
        it 'caches the added recipients' do
          subject.add_recipient(first_recipient)
          subject.add_recipient(second_recipient)
          expect(subject.recipients).to match_array(recipients)
        end
      end

      context 'cache_recipients: false' do
        subject { described_class.new(id, cache_recipients: false) }

        it 'does not cache the added recipients' do
          subject.add_recipient(first_recipient)
          subject.add_recipient(second_recipient)
          expect(subject.recipients).to match_array([second_recipient])
        end
      end
    end

    describe '#add_to_smtpapi' do
      let(:id) { rand(8999) }
      let(:smtpapi) { Smtpapi::Header.new }

      it 'adds enabled and the templates id' do
        expect(smtpapi).to receive(:add_filter).with(:templates, :enable, 1)
        expect(smtpapi).to receive(:add_filter).with(:templates, :template_id, id)
        subject.add_to_smtpapi(smtpapi)
      end

      context 'smtpapi is nil' do
        it 'does not error' do
          expect do
            subject.add_to_smtpapi(nil)
          end.to_not raise_error
        end
      end

      context 'with recipients' do
        let(:substitution_key) { :foo }
        let(:substitution_value) { :bar }
        let(:recipients) do
          [].tap do |recipients|
            3.times.each do
              r = Recipient.new("test+#{ rand(100) }@example.com")
              r.add_substitution(substitution_key, substitution_value)
              recipients << r
            end
          end
        end

        before do
          recipients.each do |r|
            subject.add_recipient(r)
          end
        end

        it 'calls the recipients call to add to smtpapi' do
          recipients.each do |recipient|
            expect(recipient).to receive(:add_to_smtpapi).with(smtpapi)
          end

          subject.add_to_smtpapi(smtpapi)
        end
      end
    end
  end
end

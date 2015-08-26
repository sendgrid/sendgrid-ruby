require_relative '../../../lib/sendgrid/template'

module SendGrid
  describe Template do
    let(:id) { anything }
    subject { described_class.new(id) }

    describe '#initialize' do
      it 'sets the id instance var' do
        expect(subject.instance_variable_get(:@id)).to_not be_nil
      end
    end

    describe '#add_to_smtpapi' do
      let(:id) { rand(8999) }
      let(:smtpapi) { Smtpapi::Header.new }

      it 'adds enabled and the templates id' do
        expect(smtpapi).to receive(:add_filter).with(:template, :enabled, 1)
        expect(smtpapi).to receive(:add_filter).with(:template, :id, id)
        subject.add_to_smtpapi(smtpapi)
      end

      context 'smtpapi is nil' do
        it 'does not error' do
          expect do
            subject.add_to_smtpapi(nil)
          end.to_not raise_error
        end
      end
    end
  end
end

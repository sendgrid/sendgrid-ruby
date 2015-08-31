require_relative '../../../lib/sendgrid/recipient'

module SendGrid
  describe Recipient do
    subject { described_class.new(anything) }

    describe '#initialize' do
      it 'sets the address instance var' do
        expect(subject.instance_variable_get(:@address)).to_not be_nil
      end

      it 'sets substitutions to an empty hash' do
        expect(subject.instance_variable_get(:@substitutions)).to eq({})
      end

      context 'initialized with nil' do
        it 'raises an error' do
          expect do
            described_class.new(nil)
          end.to raise_error(Recipient::NoAddress, 'Recipient address cannot be nil')
        end
      end
    end

    describe '#add_substitution' do
      it 'adds the key and value to the substitutions hash' do
        subject.add_substitution(:foo, :bar)
        expect(subject.substitutions).to have_key(:foo)
        expect(subject.substitutions[:foo]).to eq(:bar)
      end

      context 'the same substiution key already exists' do
        before do
          subject.add_substitution(:foo, :bar)
        end

        it 'replaces the value' do
          subject.add_substitution(:foo, :baz)
          expect(subject.substitutions).to have_key(:foo)
          expect(subject.substitutions[:foo]).to eq(:baz)
        end
      end
    end

    describe '#add_to_smtpapi' do
      let(:substitutions) { { foo: :bar, baz: :qux } }
      let(:smtp_api) { Smtpapi::Header.new }
      before do
        substitutions.each do |key, value|
          subject.add_substitution(key, value)
        end
      end

      it 'adds the address' do
        expect(smtp_api).to receive(:add_to)
        subject.add_to_smtpapi(smtp_api)
      end

      it 'calls add_substitution as many times as there are substitution keys' do
        substitutions.each do |key, value|
          expect(smtp_api).to receive(:add_substitution).with(key, [value])
        end

        subject.add_to_smtpapi(smtp_api)
      end

      context 'a substitution for the same key already exists' do
        let(:substitutions) { { foo: :bar } }
        let(:added_value) { [:bar, :rab] }

        before do
          smtp_api.add_substitution(:foo, [:rab])
        end

        it 'adds to it' do
          expect(smtp_api).to receive(:add_substitution).with(:foo, array_including(added_value))
          subject.add_to_smtpapi(smtp_api)
        end
      end

      context 'substitutions is empty' do
        let(:substitutions) { {} }

        it 'does nothing' do
          expect(smtp_api).to_not receive(:add_substitution)
          subject.add_to_smtpapi(smtp_api)
        end
      end
    end
  end
end

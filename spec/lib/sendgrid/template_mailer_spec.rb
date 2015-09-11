require_relative '../../../lib/sendgrid/template_mailer'

module SendGrid
  describe TemplateMailer do
    let(:client) { anything }
    let(:template) { Template.new(anything) }
    let(:recipients) { [Recipient.new(anything)] }

    describe '#initialize' do
      let(:client) { anything }
      let(:template) { Template.new(anything) }
      let(:recipients) { [anything] }

      subject { described_class.new(client, template, recipients) }

      it 'sets the instance variables' do
        expect(subject.instance_variable_get(:@client)).to_not be_nil
        expect(subject.instance_variable_get(:@template)).to_not be_nil
        expect(subject.instance_variable_get(:@recipients)).to_not be_nil
      end

      context 'nil variables' do
        context 'template is nil' do
          let(:template) { nil }

          it 'raises error' do
            expect do
              subject
            end.to raise_error(InvalidTemplate, 'Template must be present')
          end
        end

        context 'client is nil' do
          let(:client) { nil }

          it 'raises error' do
            expect do
              subject
            end.to raise_error(InvalidClient, 'Client must be present')
          end
        end
      end

      context 'recipients' do
        let(:first_recipient) { Recipient.new('someone@anything.com') }
        let(:second_recipient) { Recipient.new('test@test.com') }
        let(:recipients) { [first_recipient, second_recipient] }

        it 'adds them to the template' do
          expect(template).to receive(:add_recipient).with(first_recipient)
          expect(template).to receive(:add_recipient).with(second_recipient)

          subject
        end
      end
    end

    describe '#mail' do
      subject { described_class.new(client, template, recipients) }

      let(:mail_params) { {} }
      let(:mail_to_h) { '' }

      before do
        allow(subject).to receive(:mail_params) { mail_params }
        allow_any_instance_of(Mail).to receive(:to_h) { mail_to_h }
        allow(client).to receive(:send)
      end

      it 'creates a new mail object' do
        expect(Mail).to receive(:new).with(mail_params).and_call_original
        subject.mail
      end

      it 'adds the template to the mail object' do
        expect_any_instance_of(Mail).to receive(:template=).with(template)
        subject.mail
      end

      it 'calls send on the client with the mail object' do
        expect(client).to receive(:send).with(mail_to_h)
        subject.mail
      end
    end
  end
end

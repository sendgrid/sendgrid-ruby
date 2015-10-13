require 'spec_helper'

describe 'SendGrid::Mail' do
  before(:each) do
    @mail = SendGrid::Mail.new
  end

  it 'should create an instance' do
    expect(SendGrid::Mail.new).to be_an_instance_of(SendGrid::Mail)
  end

  describe 'add_to_name' do
    it 'should accept a name' do
      @mail.add_to_name('Frank Foo')
      expect(@mail.to_name).to eq(['Frank Foo'])
    end

    it 'should accept an array of names' do
      @mail.add_to_name(['Frank Foo', 'Bob Bar'])
      expect(@mail.to_name).to eq(['Frank Foo', 'Bob Bar'])
    end
  end

  describe 'add_to' do
    it 'should accept an email' do
      @mail.add_to('foo@example.com')
      expect(@mail.to).to eq(['foo@example.com'])

      @mail.add_to('bar@example.com')
      expect(@mail.to).to eq(['foo@example.com', 'bar@example.com'])
    end

    it 'should accept an email and name' do
      @mail.add_to('foo@example.com', 'Frank Foo')
      expect(@mail.to).to eq(['foo@example.com'])
      expect(@mail.to_name).to eq(['Frank Foo'])

      @mail.add_to('bar@example.com', 'Bob Bar')
      expect(@mail.to).to eq(['foo@example.com', 'bar@example.com'])
      expect(@mail.to_name).to eq(['Frank Foo', 'Bob Bar'])
    end

    it 'should accept an array of emails' do
      @mail.add_to(['foo@example.com', 'bar@example.com'])
      expect(@mail.to).to eq(['foo@example.com', 'bar@example.com'])
    end

    it 'should accept an array of emails and names' do
      @mail.add_to(['foo@example.com', 'bar@example.com'], ['Frank Foo', 'Bob Bar'])
      expect(@mail.to).to eq(['foo@example.com', 'bar@example.com'])
      expect(@mail.to_name).to eq(['Frank Foo', 'Bob Bar'])
    end
  end

  describe 'add_cc' do
    it 'should accept an email' do
      @mail.add_cc('foo@example.com')
      expect(@mail.cc).to eq(['foo@example.com'])
    end

    it 'should accept an email and a name' do
      @mail.add_cc('foo@example.com', 'Frank Foo')
      expect(@mail.cc).to eq(['foo@example.com'])
      expect(@mail.cc_name).to eq(['Frank Foo'])
    end

    it 'should accept an array of emails' do
      @mail.add_cc(['foo@example.com', 'bar@example.com'])
      expect(@mail.cc).to eq(['foo@example.com', 'bar@example.com'])
    end

    it 'should accept an array of emails and names' do
      @mail.add_cc(['foo@example.com', 'bar@example.com'], ['Frank Foo', 'Bob Bar'])
      expect(@mail.cc).to eq(['foo@example.com', 'bar@example.com'])
      expect(@mail.cc_name).to eq(['Frank Foo', 'Bob Bar'])
    end
  end

  describe 'add_bcc' do
    it 'should accept an email' do
      @mail.add_bcc('foo@example.com')
      expect(@mail.bcc).to eq(['foo@example.com'])
    end

    it 'should accept an email and a name' do
      @mail.add_bcc('foo@example.com', 'Frank Foo')
      expect(@mail.bcc).to eq(['foo@example.com'])
      expect(@mail.bcc_name).to eq(['Frank Foo'])
    end

    it 'should accept an array of emails' do
      @mail.add_bcc(['foo@example.com', 'bar@example.com'])
      expect(@mail.bcc).to eq(['foo@example.com', 'bar@example.com'])
    end

    it 'should accept an array of emails and names' do
      @mail.add_bcc(['foo@example.com', 'bar@example.com'], ['Frank Foo', 'Bob Bar'])
      expect(@mail.bcc).to eq(['foo@example.com', 'bar@example.com'])
      expect(@mail.bcc_name).to eq(['Frank Foo', 'Bob Bar'])
    end
  end

  describe 'to' do
    it 'should be set' do
      @mail.to = 'foo@example.com'
      expect(@mail.to).to eq('foo@example.com')
    end
  end

  describe 'from_name' do
    it 'should be set' do
      @mail.from_name = 'Frank Foo'
      expect(@mail.from_name).to eq('Frank Foo')
    end
  end

  describe 'reply_to' do
    it 'should be set' do
      @mail.reply_to = 'foo@example.com'
      expect(@mail.reply_to).to eq('foo@example.com')
    end
  end

  describe 'smtpapi_json' do
    before do
      @mail.template = template
    end

    context 'a template has been set' do
      let(:template) { SendGrid::Template.new(anything) }

      it 'adds the template to the smtpapi header' do
        expect(@mail.template).to receive(:add_to_smtpapi).with(@mail.smtpapi)
        expect(@mail.smtpapi).to receive(:to_json)

        @mail.to_h
      end
    end

    context 'no template has been set' do
      let(:template) { nil }

      it 'does not add anything to the smtpapi header' do
        expect_any_instance_of(SendGrid::Template).to_not receive(:add_to_smtpapi)
        expect(@mail.smtpapi).to receive(:to_json)

        @mail.to_h
      end
    end
  end
end

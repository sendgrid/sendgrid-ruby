require 'spec_helper'

describe SendGrid do
  it 'should have a version' do
    SendGrid::VERSION.should_not be_nil
  end
end

describe SendGrid::Client do

  it 'should accept 2 args' do
    expect {
      SendGrid::Client.new('rbin', 'pass')
    }.to_not raise_error
  end

  it 'should raise error if more than 2 args' do

  end

  it 'should store a username and password' do
    @sg = SendGrid::Client.new('rbin', 'key')
    @sg.api_user.should == 'rbin' && @sg.api_key.should == 'key'
  end

  it 'raises 400 erorr if bad creds' do
    #mock web call return 400
    # expect {
    # @sg.send(payload)
    # }.to raise_error(FOOERRR)
  end

end

require 'spec_helper'

describe SendGrid do
  it 'should have a version' do
    SendGrid::VERSION.should_not be_nil
  end
end

describe SendGrid::Client do

  it 'should only take 2 args' do
    @sg = SendGrid::Client.new("rbin", "key")
  end

  it 'should require a username and key' do
    @sg = SendGrid::Client.new("rbin", "key")
  end

  it 'should have a username that matches input' do
    @sg = SendGrid::Client.new("rbin", "key")
    @sg.api_user.should == "rbin"
  end  

end    
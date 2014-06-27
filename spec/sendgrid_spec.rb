require 'spec_helper'

describe SendGrid do
  it 'should have a version' do
    SendGrid::VERSION.should_not be_nil
  end
end

describe SendGrid::Client do

  it 'should accept 2 args' do
    @sg = SendGrid::Client.new("rbin", "pass")
  end

  it 'should have a username matches the input arg' do
    @sg = SendGrid::Client.new("rbin", "key")
    @sg.api_user.should == "rbin"
  end  

end



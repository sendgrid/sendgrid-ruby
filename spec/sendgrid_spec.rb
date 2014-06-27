require 'spec_helper'

describe SendGrid do
  it 'should have a version' do
    SendGrid::VERSION.should_not be_nil
  end
end
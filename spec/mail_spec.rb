require 'spec_helper'
require 'SendGrid/Mail'

describe SendGrid::Mail do

  it 'should include a *To* address' do
    @m = SendGrid::Mail.new("rbin@sendgrid.com")
    expect(@m.to).to_not be_nil
  end


end
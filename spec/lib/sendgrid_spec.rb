require 'spec_helper'

describe 'SendGrid' do
  it 'should have a version' do
    expect(SendGrid::VERSION).to eq('0.0.3')
  end
end

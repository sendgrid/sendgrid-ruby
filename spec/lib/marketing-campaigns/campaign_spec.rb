require 'spec_helper'

describe 'MarketingCampaigns::Campaign' do
  before(:each) do
    @campaign = MarketingCampaigns::Campaign.new
  end

  it 'should create an instance' do
    expect(MarketingCampaigns::Campaign.new).to be_an_instance_of(MarketingCampaigns::Campaign)
  end

  describe 'title' do
    it 'should accept a title' do
      @campaign.title = 'Frank Foo'
      expect(@campaign.title).to eq('Frank Foo')
    end
  end

  describe 'subject' do
    it 'should accept a subject' do
      @campaign.subject = 'Frank Foo'
      expect(@campaign.subject).to eq('Frank Foo')
    end
  end

  describe 'sender_id' do
    it 'should accept a title' do
      @campaign.sender_id = 1
      expect(@campaign.sender_id).to eq(1)
    end
  end

  describe 'list_ids' do
    it 'should accept list ids' do
      @campaign.list_ids = [1, 2]
      expect(@campaign.list_ids).to eq([1, 2])
    end
  end

  describe 'segment_ids' do
    it 'should accept a segment id' do
      @campaign.segment_ids = [1, 2]
      expect(@campaign.segment_ids).to eq([1, 2])
    end
  end

  describe 'categories' do
    it 'should accept categories' do
      @campaign.categories = ['hello', 'world']
      expect(@campaign.categories).to eq(['hello', 'world'])
    end
  end

  describe 'suppression_group_id' do
    it 'should accept a suppression group id' do
      @campaign.suppression_group_id = 1
      expect(@campaign.suppression_group_id).to eq(1)
    end
  end

  describe 'custom_unsubscribe_url' do
    it 'should accept a custom unsub url' do
      @campaign.custom_unsubscribe_url = 'custom url'
      expect(@campaign.custom_unsubscribe_url).to eq('custom url')
    end
  end

  describe 'html_content' do
    it 'should accept html content' do
      @campaign.html_content = '<p>testing</p>'
      expect(@campaign.html_content).to eq('<p>testing</p>')
    end
  end

  describe 'plain_content' do
    it 'should accept plain content' do
      @campaign.plain_content = 'testing'
      expect(@campaign.plain_content).to eq('testing')
    end
  end

end

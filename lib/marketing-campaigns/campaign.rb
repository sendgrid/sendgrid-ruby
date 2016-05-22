require 'json'
require 'smtpapi'
require 'mimemagic'

module MarketingCampaigns
  class Campaign
    attr_accessor :title, :subject, :sender_id, :list_ids, :segment_ids,
                  :categories, :suppression_group_id, :custom_unsubscribe_url,
                  :html_content, :plain_content

    def initialize(params = {})
      params.each do |k, v|
        send(:"#{k}=", v) unless v.nil?
      end

      build_campaign

      yield self if block_given?
    end

    # Marketing Campaigns must have a title
    # Empty by default to prevent accidental loops
    def title
      @title ||= ''
    end

    def subject
      @subject ||= ''
    end

    def sender_id
      @sender_id ||= nil
    end

    def list_ids
      @list_ids ||= []
    end

    def segment_ids
      @segment_ids ||= []
    end

    def categories
      @categories ||= []
    end


    def suppression_group_id
      @suppression_group_id ||= nil
    end

    def custom_unsubscribe_url
      @custom_unsubscribe_url ||= ''
    end


    def html_content
      @html_content ||= ''
    end

    def plain_content
      @plain_content ||= ''
    end


    def build_campaign
      payload = {
          :title => title,
          :subject => subject,
          :sender_id => sender_id,
          :list_ids => list_ids,
          :segment_ids => segment_ids,
          :categories => categories,
          :suppression_group_id => suppression_group_id,
          :custom_unsubscribe_url => custom_unsubscribe_url,
          :html_content => html_content,
          :plain_content => plain_content,
      }.reject {|_, v| v.nil? || v.empty?}

      payload
    end

    def clear_campaign
      payload = {
          :title => '',
          :subject => '',
          :sender_id => nil,
          :list_ids => [],
          :segment_ids => [],
          :categories => [],
          :suppression_group_id => nil,
          :custom_unsubscribe_url => '',
          :html_content => '',
          :plain_content => '',
      }
      payload
    end
  end
end

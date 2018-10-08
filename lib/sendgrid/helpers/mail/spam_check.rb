require 'json'

module SendGrid
  class SpamCheck

    include SendGrid::Helpers

    attr_accessor :enable, :threshold, :post_to_url

    def initialize(enable: nil, threshold: nil, post_to_url: nil)
      @enable = enable
      @threshold = threshold
      @post_to_url = post_to_url
    end

  end
end

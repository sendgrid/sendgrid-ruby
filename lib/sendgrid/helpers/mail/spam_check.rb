require 'json'

module SendGrid
  class SpamCheck
    def initialize(enable: nil, threshold: nil, post_to_url: nil)
      @enable = enable
      @threshold = threshold
      @post_to_url = post_to_url
    end

    attr_writer :enable

    attr_reader :enable

    attr_writer :threshold

    attr_reader :threshold

    attr_writer :post_to_url

    attr_reader :post_to_url

    def to_json(*)
      {
        'enable' => enable,
        'threshold' => threshold,
        'post_to_url' => post_to_url
      }.delete_if { |_, value| value.to_s.strip == '' }
    end
  end
end

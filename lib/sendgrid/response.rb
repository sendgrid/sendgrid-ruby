require 'json'

module SendGrid
  class Response
    attr_reader :code, :headers, :body, :raw_body

    def initialize(params)
      @code = params[:code]
      @headers = params[:headers]
      @body = JSON.parse(params[:body])
      @raw_body = params[:body]
    end
  end
end

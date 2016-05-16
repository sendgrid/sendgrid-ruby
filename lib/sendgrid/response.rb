require 'json'

module SendGrid
  class Response
    attr_reader :code, :headers, :body, :raw_body

    def initialize(params)
      @code = params[:code]
      @headers = params[:headers]
      @body = params[:body].present? ? JSON.parse(params[:body]) : nil
      @raw_body = params[:body].present? ? params[:body] : nil
    end
  end
end

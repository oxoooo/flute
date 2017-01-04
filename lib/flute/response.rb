module Flute
  class Response
    attr_reader :status, :body
    def initialize(response)
      @status = response.code
      @body = response.body
    end

    def success?
      200 <= @status && @status < 300
    end

    def parse_html
      @parse_html ||= Document.parse(@body)
    end

    def parse_json
      @parse_json ||= JSON.parse(@body).symbolize_keys
    end

  end
end
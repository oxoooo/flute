module Flute
  class Request < Typhoeus::Request
    def meta
      @meta
    end

    def meta=(item)
      @meta = item
    end

    def response_html
      Document.parse response.body
    end

    def response_json
      JSON.parse(response.body).symbolize_keys
    end
  end
end
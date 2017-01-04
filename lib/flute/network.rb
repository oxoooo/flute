module Flute
  class Network
    def get(url, params: {}, headers: {})
      options = make_options params, headers
      response = Typhoeus.get(url, options)
      Response.new response
    end

    def request(url,  params: {}, headers: {}, method: :get, body: {})
      options = make_options params, headers
      request = Request.new url, options.merge(method: method, body: body)      
      request
    end

    def make_options(params={}, headers={})
      options = {
          headers: headers,
          params: params,
          followlocation: true,
          accept_encoding: 'gzip'
      }      
      options
    end

    def create_manager(max_concurrency: 5)
      Typhoeus::Hydra.new(max_concurrency: max_concurrency)
    end
  end
end
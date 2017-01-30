module GooglePlaces
  class Response
    attr_reader :body

    def initialize(endpoint, raw_response)
      @endpoint = endpoint
      @raw_response = raw_response
      @body = parse(raw_response.body)

      invalid_key! if invalid_key?
    end

    def success?
      ['OK', 'ZERO_RESULTS'].include? status
    end

    def error_messages
      body['error_message']
    end

    def status
      body['status']
    end

    def invalid_key!
      raise Errors::InvalidKeyError
    end

    def invalid_key?
      status == 'REQUEST_DENIED'
    end

    def page_token
      body['next_page_token']
    end

    def results
      Result.new(body['results'])
    end

    def next_page
      RequestPerformer.make_request(endpoint, pagetoken: page_token)
    end

    private
      attr_reader :raw_response, :endpoint

      def parse(body)
        JSON.parse(body)
      end
  end
end

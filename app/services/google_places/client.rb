module GooglePlaces
  BASE_ENDPOINT = "https://maps.googleapis.com/maps/api/place"

  class Client
    class << self
      def connection
        ::Faraday::Connection.new(BASE_ENDPOINT) do |connection|
            connection.use ::Faraday::Request::Multipart
            connection.use ::Faraday::Request::UrlEncoded
            connection.response :logger, Rails.logger if log_api_request?
            connection.adapter ::Faraday.default_adapter
            connection.params[:key] = ENV['google_places_api_key']
          end
      end

      def request(http_method, path, options)
        connection.send(http_method, path, options)
      end

      private
        def log_api_request?
          false # we might want to consider using a config setting to determine whether these requests should be logged or not
        end
    end
  end
end

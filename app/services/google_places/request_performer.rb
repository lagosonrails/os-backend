module GooglePlaces
  module RequestPerformer
    def self.make_request(endpoint, params)
      response = GooglePlaces::Client.request(:get, endpoint, params)
      GooglePlaces::Response.new(endpoint, response)
    end
  end
end

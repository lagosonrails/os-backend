module GooglePlaces::Errors
  class InvalidKeyError < StandardError
    def message
      <<-EOF
        Please provide a valid Google API key. You can set an ENV['google_places_api_key'] variable.
        To get a valid API key please
        1. Visit https://console.developers.google.com
        2. Create a credential and select `API key`
        3. Enable the "Google Places API Web Service"
        4. Copy and Paste the API key gotten in `2` above and set your ENV variable
      EOF
    end
  end
end

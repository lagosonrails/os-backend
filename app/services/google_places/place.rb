module GooglePlaces
  class Place
    attr_reader :id, :name, :location, :latitude, :longitude

    def initialize(place)
      @raw_place = place
      @id = place['place_id']
      @name = place['name']
      @location = place['vicinity']
      load_geometry place['geometry']
    end

    def load_geometry(geometry)
      if geometry && geometry['location']
        @latitude = geometry['location']['lat']
        @longitude = geometry['location']['lng']
      end
    end

    private
      attr_reader :raw_place
  end
end

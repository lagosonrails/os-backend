class GooglePlacesService
  class << self
    def text_search(*args)
      search_type = GooglePlaces::SearchTypes::TextSearch.new
      search = search_type.search(*args)

    end

    def radar_search(args)
      search_type = GooglePlaces::SearchTypes::RadarSearch.new
      search = search_type.search(*args)
    end
  end
end

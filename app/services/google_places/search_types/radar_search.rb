module GooglePlaces::SearchTypes
  class RadarSearch
    include GooglePlaces::SearchTypes::Base

    def type
      'radarsearch'
    end

    def required_params_for_search
      [ :location, :radius ]
    end

  end
end

module GooglePlaces::SearchTypes
  class TextSearch
    include GooglePlaces::SearchTypes::Base

    def type
      'textsearch'
    end

    def required_params_for_search
      [:query]
    end

  end
end

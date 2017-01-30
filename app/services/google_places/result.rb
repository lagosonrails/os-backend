module GooglePlaces
  class Result < Struct.new(:results)
    delegate :empty?, :any?, :blank?, :present?, :all?, to: :results
    
    def places
      results.map {|place| Place.new(place) }
    end
  end
end

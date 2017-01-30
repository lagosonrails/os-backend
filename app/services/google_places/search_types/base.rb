module GooglePlaces::SearchTypes::Base
  def endpoint
    "#{type}/json"
  end

  def search(*args)
    params = args.extract_options!
    check_for_required_params(params, required_params: required_params_for_search)

    perform_request(params)
  end

  private
    def required_params_for_search
      []
    end

    def check_for_required_params(hash, required_params:)
      # comparison may be made against string or symbols
      indifferent_hash = HashWithIndifferentAccess.new(hash)

      required_params.each do |param|
        raise GooglePlaces::Errors::MissingRequiredKeyError.new(nil, self) unless indifferent_hash.has_key? param
      end
    end


    def perform_request(params)
      GooglePlaces::RequestPerformer.make_request(endpoint, params)
    end
end

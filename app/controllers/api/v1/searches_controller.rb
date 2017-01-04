class Api::V1::SearchesController < ApplicationController

=begin
  @apiVersion 1.0.0
  @api {get} /api/v1/search Search for Address by query params
  @apiGroup Search

  @apiExample {url} Url Example for Coordinates
            http://example.com/api/v1/search?coordinates[latitude]=1.54&coordinates[longitude]=7.63
  @apiExample {url} Url Example for Company
            http://example.com/api/v1/search?company[name]=gtbank
  @apiExample {url}Url Example for location
            http://example.com/api/v1/search?location=lagos
  @apiExample {url} Url Example for combined query
            http://example.com/api/v1/search?coordinates[latitude]=1.54&coordinates[longitude]=7.63&company[name]=gtbank


  @apiParam {Object} [coordinates] Coordinate object of the location
  @apiParam {Float} [coordinates.latitude] latitude to search
  @apiParam {Float} [coordinates.longitude] longitude to search
  @apiParam {Object} [company] company object to scope by
  @apiParam {String} [company.name] name of the company to search
  @apiParam {String} [location] location of the place to search

  @apiSuccess {Object[]} addresses Array of Address Objects
  @apiSuccess {Integer}  addresses.id Address ID
  @apiSuccess {String}  addresses.address_1 address_1 of the location
  @apiSuccess {String}  addresses.address_2 address_2 of the location
  @apiSuccess {String}  addresses.city city of the location
  @apiSuccess {String}  addresses.state state of the location
  @apiSuccess {String}  addresses.country country of the location
  @apiSuccess {Flaot}  addresses.longitude longitude of the location
  @apiSuccess {Float}  addresses.latitude latitude of the location
  @apiSuccess {Float}  addresses.postal_code postal_code of the location
  @apiSuccess {Float}  addresses.active active state of the ATM
  @apiSuccess {Float}  addresses.formatted_address full text string of the location
  @apiSuccess {Object}  addresses.company Company object of the address
  @apiSuccess {Integer}  addresses.company.id ID of the Company
  @apiSuccess {String}  addresses.company.name name of the Company operating the ATM
  @apiSuccess {String}  addresses.company.slug slug of the Company operating the ATM
=end

  def search
    @addresses = Address.includes(:company)
    @addresses = @addresses.references(:company).where("companies.name LIKE ?", "%#{company_name}%") if scoped_to_company?
    @addresses = scope_to_location(@addresses, geoserialize_coordinates_and_location_params) if scoped_to_location?

    render 'api/v1/addresses/index', status: :ok
  end

  private

  def scoped_to_company?
    params[:company] && params[:company][:name]
  end

  def scoped_to_location?
    params[:location] || (params[:coordinates] && params[:coordinates][:latitude])
  end

  def company_name
    params[:company][:name] if params[:company]
  end

  def geoserialize_coordinates_and_location_params
    if params[:coordinates]
      [
        params[:coordinates][:latitude],
        params[:coordinates][:longitude]
      ]
    elsif params[:location]
      params[:location]
    end
  end

  def scope_to_location(collection, location)
    collection.near(location, 20, units: :km) # allow client to set radius of search or let front end do the calculations
  end

  def query_params
    # determine whether this nesting would be necessary
    params[:query]
  end

end

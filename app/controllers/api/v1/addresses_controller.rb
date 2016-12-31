class Api::V1::AddressesController < ApplicationController
    before_action :find_company, if: :scoped_to_company?
    before_action :find_address, except: [:create, :index]

=begin
  @apiVersion 1.0.0
  @api {get} /api/v1/addresses Index route of the addresses
  @apiGroup Address Endpoints

  @apiExample {url} Url Example for Address
            http://example.com/api/v1/addresses
  @apiExample {url} Url Example for Address
            http://example.com/api/v1/companies/:company_id_or_slug/addresses

  @apiParam {Integer} [company_slug_or_id] slug or id of the company


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
    def index
      @addresses = address_resource.includes(:company).all
    end

=begin
  @apiVersion 1.0.0
  @api {post} /api/v1/addresses Create endpoint for the address
  @apiGroup Address Endpoints

  @apiExample {url} Url Example for Coordinates
            http://example.com/api/v1/addresses


  @apiParam {Object} address Address object
  @apiParam {Integer} address.company_id Company ID for the location
  @apiParam {String} address.address_1 address_1 attribute of the location
  @apiParam {String} address.address_2 address_2 attribute of the location
  @apiParam {String} address.city city of the atm location
  @apiParam {String} address.state state of the atm location
  @apiParam {String} address.country country of the atm location
  @apiParam {String} address.postal_code postal_code of the atm location
  @apiParam {String} address.latitude latitude of the atm location
  @apiParam {String} address.latitude longitude of the atm location


  @apiSuccess {Object}  address Address ID
  @apiSuccess {Integer}  address.id Address ID
  @apiSuccess {String}  address.address_1 address_1 of the location
  @apiSuccess {String}  address.address_2 address_2 of the location
  @apiSuccess {String}  address.city city of the location
  @apiSuccess {String}  address.state state of the location
  @apiSuccess {String}  address.country country of the location
  @apiSuccess {Flaot}  address.longitude longitude of the location
  @apiSuccess {Float}  address.latitude latitude of the location
  @apiSuccess {Float}  address.postal_code postal_code of the location
  @apiSuccess {Float}  address.active active state of the ATM
  @apiSuccess {Float}  address.formatted_address full text string of the location
  @apiSuccess {Object}  address.company Company object of the address
  @apiSuccess {Integer}  address.company.id ID of the Company
  @apiSuccess {String}  address.company.name name of the Company operating the ATM
  @apiSuccess {String}  address.company.slug slug of the Company operating the ATM
=end
    def create
      @address = address_resource.new(address_params)
      if @address.save
        render :show, status: :created#, location: @post
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    def update
      if @address.update(address_params)
        render :show,  status: :ok#, location: @post
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    def destroy
      # determine how records should be removed
      @address.archive
    end

    def show
    end

    private
      def find_address
        @address = address_resource.find(params[:id])
      end

      def find_company
        @company = Company.friendly.find(params[:company_id])
      end

      def address_resource
        @address_resource ||= (scoped_to_company? && @company.addresses) || Address
      end

      def scoped_to_company?
        params[:company_id].present?
      end

      def address_params
        params.require(:address).permit(
          :company_id,
          :address_1,
          :address_2,
          :city,
          :state,
          :country,
          :postal_code,
          :latitude,
          :longitude
        )
      end
end

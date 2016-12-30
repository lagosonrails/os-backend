class Api::V1::AddressesController < ApplicationController
    before_action :find_company, if: :scoped_to_company?
    before_action :find_address, except: [:create, :index]

    def index
      @addresses = address_resource.includes(:company).all
    end

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

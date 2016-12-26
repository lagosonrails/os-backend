class Api::V1::AddressesController < ApplicationController
    before_action :find_company, if: :scoped_to_company?
    before_action :find_address, except: [:create, :index]

    def index
      @addresses = (scoped_to_company? && @company.addresses) || Address.includes(:company).all
    end

    def create

    end

    def update

    end

    def destroy

    end

    private
      def find_address
        @address = (scoped_to_company? && @company.addresses.find(params[:id])) ||
                    Address.find(params[:id])
      end

      def find_company
        @company = Company.friendly.find(params[:company_id])
      end

      def scoped_to_company?
        params[:company_id].present?
      end

      def address_params

      end
end

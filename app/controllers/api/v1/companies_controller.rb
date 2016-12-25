class Api::V1::CompaniesController < ApplicationController
  before_action :find_company, except: [:create, :index]

  def index

  end

  def create

  end

  def update

  end

  def destroy

  end

  private
    def find_company
      @company = Company.find(params[:id])
    end

    def company_params

    end
end

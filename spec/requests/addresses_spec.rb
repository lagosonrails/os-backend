require 'rails_helper'

RSpec.describe "Addresses API", type: :request do
  describe "GET /api/v1/addresses" do

    it "should return a success response status" do
      get '/api/v1/addresses'

      expect(response).to have_http_status(200)
    end

    it "should return all addresses" do
      #determine how we want to present addresses here? closest stores? how many km? number of stores to display

    end
  end

  describe "GET /api/v1/:company_id_or_slug/addresses" do

    it "should return a success response status" do
      get '/api/v1/:company_id_or_slug/addresses'

      expect(response).to have_http_status(200)
    end


    it "should return all addresses for a specific company" do
      get '/api/v1/:company_id_or_slug/addresses'

      expect(json[:locations]).not_to be_empty
    end
  end


end

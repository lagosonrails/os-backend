require 'rails_helper'

RSpec.describe "Addresses API", type: :request do
  let! (:company)  { create(:company) }

  describe "GET /api/v1/addresses" do
    let! (:company_addresses) { create_list(:address, 5, company: company) }

    before do
      create_list(:address, 5)
    end
    it "should return a success response status" do
      get '/api/v1/addresses'

      expect(response).to have_http_status(200)
    end

    it "should return all addresses" do
      # determine how we want to present addresses here? closest stores? how many km? number of stores to display
      get '/api/v1/addresses'

      expect(json[:addresses]).not_to be_empty
      expect(json[:addresses].size).to eql 10
    end

    describe "GET /api/v1/companies/:company_id_or_slug/addresses" do
      it "should return a success response status" do
        get "/api/v1/companies/#{company.slug}/addresses"

        expect(response).to have_http_status(200)
      end


      it "should return all addresses for a specific company" do
        get "/api/v1/companies/#{company.slug}/addresses"

        expect(json[:addresses]).not_to be_empty
        expect(json[:addresses].size).to eql 5
        expect(
          company_addresses.map(&:id)
          ).to match_array(
              json[:addresses].map{|x| x[:id] }
            )
      end
    end
  end

  describe "POST /api/v1/addresses" do
    let(:address_attributes) { attributes_for(:address) }

    it "should create new address record" do

      expect {
        post '/api/v1/addresses', address: address_attributes
      }.to change(Address, :count).by(1)

    end

    describe "POST /api/v1/companies/:company_id_or_slug/addresses" do
      it "should create new address record" do
        expect {
          post "/api/v1/companies/#{company.slug}/addresses", address: address_attributes
        }.to change(Address, :count).by(1)

      end
    end
  end


  describe "PUT /api/v1/addresses/:id" do

  end

  describe "PUT /api/v1/companies/:company_id_or_slugaddresses/:id" do

  end


end

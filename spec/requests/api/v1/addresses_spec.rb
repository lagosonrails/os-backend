require 'rails_helper'

RSpec.describe "Addresses API", type: :request do
  let! (:company)  { create(:company) }

  describe "GET /api/v1/addresses" do
    let! (:company_addresses) { create_list(:address_with_full_address, 5, company: company) }

    before do
      create_list(:address_with_full_address, 5)
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
    let(:address_attributes) { attributes_for(:address_with_full_address) }

    it "should create new address record" do

      expect {
        post '/api/v1/addresses', params: {address: address_attributes}
      }.to change(Address, :count).by(1)

      expect(response.status).to eql(201)
    end

    describe "POST /api/v1/companies/:company_id_or_slug/addresses" do
      it "should create new address record" do

        expect {
          post "/api/v1/companies/#{company.slug}/addresses", params: {address: address_attributes}
        }.to change(Address, :count).by(1)

        expect(response.status).to eql(201)
      end
    end
  end

  describe "GET /api/v1/addresses/:id" do
    subject { create(:address_with_full_address) }

    it "should return an address record" do
      get "/api/v1/addresses/#{subject.id}"

      expect(response).to be_success
      expect(json[:address]).not_to be_empty
      expect(json[:address][:id]).to eql subject.id
      expect(json[:address][:formatted_address]).to eql subject.formatted_address
    end

    describe "GET /api/v1/companies/:company_id_or_slug/addresses/:id" do
      subject { create(:address_with_full_address, company: company) }

      it "should return an address record" do
        get "/api/v1/companies/#{company.slug}/addresses/#{subject.id}"

        expect(response).to be_success
        expect(json[:address]).not_to be_empty
        expect(json[:address][:id]).to eql subject.id
        expect(json[:address][:formatted_address]).to eql subject.formatted_address
      end
    end
  end


  describe "PUT /api/v1/addresses/:id" do
    subject { create(:address_with_full_address) }
    let(:address_attributes) { {city: 'city attribute', state: 'state of emergency'} }

    it "should update the address attributes" do
      put "/api/v1/addresses/#{subject.id}", params: { address: address_attributes }

      expect(response).to be_success

      subject.reload
      expect(subject.city).to eql address_attributes[:city]
      expect(subject.state).to eql address_attributes[:state]
    end

    describe "PUT /api/v1/companies/:company_id_or_slug/addresses/:id" do
      subject { create(:address_with_full_address, company: company) }
      let(:address_attributes) { {city: 'city attribute', state: 'state of emergency'} }

      it "should update the address attributes" do
        put "/api/v1/companies/#{company.slug}/addresses/#{subject.id}", params: { address: address_attributes }

        expect(response).to be_success

        subject.reload
        expect(subject.city).to eql address_attributes[:city]
        expect(subject.state).to eql address_attributes[:state]
      end
    end
  end


  describe "DELETE /api/v1/addresses/:id" do
    subject { create(:address_with_full_address) }

    # we should never delete records for integrity and references
    it "should archive the record" do
      delete "/api/v1/addresses/#{subject.id}"

      expect(response).to be_success

      subject.reload
      expect(subject.archived?).to be true
    end

    describe "DELETE /api/v1/companies/:company_id_or_slug/addresses/:id" do
      subject { create(:address_with_full_address, company: company) }

      it "should archive the record" do
        delete "/api/v1/companies/#{company.slug}/addresses/#{subject.id}"

        expect(response).to be_success

        subject.reload
        expect(subject.archived?).to be true
      end
    end
  end


end
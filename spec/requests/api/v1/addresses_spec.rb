require 'rails_helper'

RSpec.describe "Addresses API", type: :request do
  let! (:company)  { create(:company) }

  context "[UNSCOPED] when request is not scoped to company" do
    describe "GET /api/v1/addresses" do
      let! (:company_addresses) { create_list(:address_with_full_address, 5, company: company) }

      before do
        create_list(:address_with_full_address, 5)
        get '/api/v1/addresses'
      end

      it "should return a success response status" do
        expect(response).to have_http_status(200)
      end

      it "should return all addresses" do
        # determine how we want to present addresses here? closest stores? how many km? number of stores to display
        expect(json[:addresses]).not_to be_empty
        expect(json[:addresses].size).to eql 10
      end

      it { expect(response).to match_response_schema('addresses/index') }
    end

    describe "POST /api/v1/addresses" do
      let(:address_attributes) { attributes_for(:address_with_full_address) }

      it "should create new address record" do

        expect {
          post '/api/v1/addresses', params: {address: address_attributes}
        }.to change(Address, :count).by(1)

        expect(response).to be_success
      end
    end

    describe "GET /api/v1/addresses/:id" do
      subject { create(:address_with_full_address) }

      before do
        get "/api/v1/addresses/#{subject.id}"
      end

      it { expect(response).to match_response_schema('addresses/show') }

      it "should return an address record" do
        expect(response).to be_success
        expect(json[:address]).not_to be_empty
        expect(json[:address][:id]).to eql subject.id
        expect(json[:address][:formatted_address]).to eql subject.formatted_address
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
    end
  end


  context "[SCOPED] when request is scoped to company" do

    describe "GET /api/v1/companies/:company_id_or_slug/addresses" do
      let! (:company_addresses) { create_list(:address_with_full_address, 5, company: company) }

      before do
        create_list(:address_with_full_address, 5)
        get "/api/v1/companies/#{company.slug}/addresses"
      end

      it "should return a success response status" do
        expect(response).to have_http_status(200)
      end

      it { expect(response).to match_response_schema('addresses/index') }

      it "should return all addresses for a specific company" do
        expect(json[:addresses]).not_to be_empty
        expect(json[:addresses].size).to eql 5
        expect(
          company_addresses.map(&:id)
          ).to match_array(
              json[:addresses].map{|x| x[:id] }
            )
      end
    end

    describe "POST /api/v1/companies/:company_id_or_slug/addresses" do
      let(:address_attributes) { attributes_for(:address_with_full_address) }

      it "should create new address record" do
        expect {
          post "/api/v1/companies/#{company.slug}/addresses", params: {address: address_attributes}
        }.to change(Address, :count).by(1)

        expect(response).to be_success
      end
    end

    describe "GET /api/v1/companies/:company_id_or_slug/addresses/:id" do
      subject { create(:address_with_full_address, company: company) }

      before do
        get "/api/v1/companies/#{company.slug}/addresses/#{subject.id}"
      end

      it { expect(response).to match_response_schema('addresses/show') }

      it "should return an address record" do
        expect(response).to be_success
        expect(json[:address]).not_to be_empty
        expect(json[:address][:id]).to eql subject.id
        expect(json[:address][:formatted_address]).to eql subject.formatted_address
      end
    end

    describe "PUT /api/v1/companies/:company_id_or_slug/addresses/:id" do
      subject { create(:address_with_full_address, company: company) }
      let(:address_attributes) { {city: 'city attribute', state: 'state of emergency'} }

      before do
        put "/api/v1/companies/#{company.slug}/addresses/#{subject.id}", params: { address: address_attributes }
      end

      it "should update the address attributes" do
        expect(response).to be_success

        subject.reload
        expect(subject.city).to eql address_attributes[:city]
        expect(subject.state).to eql address_attributes[:state]
      end
    end

    describe "DELETE /api/v1/companies/:company_id_or_slug/addresses/:id" do
      subject { create(:address_with_full_address, company: company) }

      before do
        delete "/api/v1/companies/#{company.slug}/addresses/#{subject.id}"
      end

      it "should archive the record" do
        expect(response).to be_success

        subject.reload
        expect(subject.archived?).to be true
      end
    end
  end

end

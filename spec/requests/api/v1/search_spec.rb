require 'rails_helper'

RSpec.describe "Search API", type: :request do

    describe "GET /api/v1/search" do
      let!(:company_1) { create(:company, name: 'gtbank') }
      let!(:company_2) { create(:company, name: 'AccessBank') }
      let!(:company_1_addresses) { create_list(:address_with_full_address, 5, company: company_1)}
      let!(:company_2_addresses) { create_list(:address_with_full_address, 5, company: company_2)}


      before do
        get "/api/v1/search", params: search_params
      end

      context "when searching by company name" do
        let(:search_params) { { company: {name: 'gtbank'} } }

        it "should only return results for a specific company" do
          companies = json[:addresses].map{|x| x[:company] }

          expect(json[:addresses].size).to eql 5
          expect( companies.uniq.size ).to eql 1
        end
      end

      context "when searching by coordinates" do
        let(:search_params) { {coordinates: {latitude: 6.508, longitude: 3.375}} }

        it "should return locations within a certain radius of the coordinates given" do
          expect(json[:addresses].size).to eql 10
        end
      end

      context "when searching by location" do
        before do
          create(:address, address_1: 'Yaba', company: company_1)
        end

        let(:search_params) { {location: 'Yaba'} }

        it "should return locations within a certain radius of the location given" do
          expect(json[:addresses].size).to eql 1
        end
      end

      context "when combining multiple queries" do
        before do
          create_list
        end

        let(:search_params) { {location: 'Warri', company: {name: 'Stanbic' }} }
      end
    end

end

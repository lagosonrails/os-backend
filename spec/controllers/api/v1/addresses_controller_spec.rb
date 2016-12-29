require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do
  describe "#index" do
    it "should return a successful response" do
      get :index, format: :json

      expect(response).to be_success
    end
  end
end

require 'rails_helper'

RSpec.describe "Companies API", type: :request do
  describe "GET /companies" do
    it "should return a success response status" do
      get "/api/v1/companies"
      
      expect(response).to have_http_status(200)
    end
  end
end

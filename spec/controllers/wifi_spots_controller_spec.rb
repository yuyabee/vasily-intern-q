require 'rails_helper'

RSpec.describe WifiSpotsController, type: :controller do
  describe "GET index" do
    let(:params) {
      { lat: 35.76410755, lng: 140.384596, lang: "en", distance: 1000, limit: 15,  }
    }

    it "responds successfully with the params" do
      get :index, params: params

      expect(response).to be_success
    end

    it "responds with error when negative distance is given" do
      get :index, params: params.merge({ distance: -100 })

      expect(response).to be_bad_request
      expect(JSON.parse(response.body)).to include("distance")
    end

    it "responds with error when lang other than ja or en is given" do
      get :index, params: params.merge({ lang: "fr" })

      expect(response).to be_bad_request
      expect(JSON.parse(response.body)).to include("lang")
    end

    it "responds with error when location is not given" do
      get :index, params: params.reject {|k, v| [:lat, :lng].include?(k) }

      expect(response).to be_bad_request
      expect(JSON.parse(response.body)).to include("geo_point")
    end

    it "responds with error when location is not given" do
      get :index, params: params.reject {|k, v| [:lat, :lng].include?(k) }

      expect(response).to be_bad_request
      expect(JSON.parse(response.body)).to include("geo_point")
    end
  end
end

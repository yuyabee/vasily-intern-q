require 'rails_helper'

require 'csv'

RSpec.describe WifiSpotsController, type: :controller do
  describe "GET index" do
    let!(:wifi_spots) {
      spots = []
      CSV.foreach("#{Rails.root}/db/jta_free_wifi.csv", {headers: true}).with_index do |r, idx|
        break if idx == 100
        spots << WifiSpot.new(name_ja: r[1], name_en: r[2], address_ja: r[8], address_en: r[9], latitude: r[18], longitude: r[19])
      end

      WifiSpot.import spots
    }

    let(:params) {
      { lat: 35.76410755, lng: 140.384596, lang: "en", distance: 10000000, limit: 4,  }
    }

    # default filter should be limit: 5, distance: 500, lang: ja, and either [lat, lng] or location must be given as parameter
    let(:default_params) {
      # exact point of one of the wifi spot in the database (one of the first 100)
      { lat: 35.76381035, lng: 140.38389382 }
    }

    it "responds successfully to default params" do
      get :index, params: default_params

      expect(response).to be_success
      # one point where 5 wifi spots are with 500m is needed to fully test this
      # feature but for the purpose of the quiz i don't think it's worth ...
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json[0]).to include("name_ja")
      expect(json[0]).to include("address_ja")
      expect(json[0]).to include("distance")
    end

    it "responds successfully to params" do
      get :index, params: params

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.size).to eq(4)
      expect(json[0]).to include("name_en")
      expect(json[0]).to include("address_en")
      expect(json[0]).to include("distance")
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

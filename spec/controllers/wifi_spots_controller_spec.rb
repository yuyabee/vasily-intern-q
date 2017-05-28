require 'rails_helper'

RSpec.describe WifiSpotsController, type: :controller do
  describe "GET index" do
    let(:lat) { 35.76410755 }
    let(:lng) { 140.384596 }

    it "assigns default values to @limit and @distance" do
      get :index, params: { lat: lat, lng: lng }
      expect(assigns(:limit)).to eq(5)
      expect(assigns(:distance)).to eq(500)
    end

    it "assigns @geo_point with the given lat and lng" do
      get :index, params: { lat: lat, lng: lng }
      expect(assigns(:geo_point)).to eq([lat, lng])
    end
  end
end

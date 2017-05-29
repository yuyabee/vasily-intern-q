require 'rails_helper'

RSpec.describe WifiSpotsController, type: :controller do
  describe "GET index" do
    let(:lat) { 35.76410755 }
    let(:lng) { 140.384596 }
    let(:lang) { "en" }
    let(:distance) { 1000 }
    let(:limit) { 15 }
    let(:search) { "新宿" }

    it "assigns default values to @limit, @distance and @lang" do
      get :index, params: { lat: lat, lng: lng }

      expect(assigns(:limit)).to eq(5)
      expect(assigns(:distance)).to eq(500)
      expect(assigns(:lang)).to eq("ja")
    end

    it "assigns @geo_point with the given lat and lng" do
      get :index, params: { lat: lat, lng: lng }

      expect(assigns(:geo_point)).to eq([lat, lng])
    end

    it "assigns params[:search] to @geo_point" do
      get :index, params: { search: search }

      expect(assigns(:geo_point)).to eq(search)
    end

    it "assigns params[:search] to @geo_point when [lat, lng] and search is given" do
      get :index, params: { lat: lat, lng: lng, search: search }

      expect(assigns(:geo_point)).to eq(search)
    end

    it "assigns @limit, @distance, and @lang with the given parameters" do
      get :index, params: { lat: lat, lng: lng, lang: lang, distance: distance, limit: limit }

      expect(assigns(:geo_point)).to eq([lat, lng])
      expect(assigns(:lang)).to eq(lang)
      expect(assigns(:distance)).to eq(distance)
      expect(assigns(:limit)).to eq(limit)
    end
  end
end

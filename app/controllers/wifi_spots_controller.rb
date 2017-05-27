class WifiSpotsController < ApplicationController
  def index
    p WifiSpot.find(1)
    render json: params.permit(:distance, :limit, :lat, :lng), status: :ok
  end
end

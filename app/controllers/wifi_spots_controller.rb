class WifiSpotsController < ApplicationController
  def index
    render json: params.permit(:distance, :limit, :lat, :lng), status: :ok
  end
end

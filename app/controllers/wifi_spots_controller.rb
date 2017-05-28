class WifiSpotsController < ApplicationController
  before_action :set_params, only: [:index]

  def index
    res = WifiSpot.near([@lat, @lng], @distance / 1000, :unit => :km).limit(@limit)

    render json: res, status: :ok
  end

  private

  def set_params
    params.permit(:lat, :lng, :distance, :limit)

    @lat = params.fetch(:lat).to_f
    @lng = params.fetch(:lng).to_f
    @limit = params.fetch(:limit, 5).to_i
    @distance = params.fetch(:distance, 500).to_i # unit: meter
  end
end

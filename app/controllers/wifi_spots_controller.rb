class WifiSpotsController < ApplicationController
  before_action :set_params, only: [:index]

  def index
    res = WifiSpot
      .near(@geo_point, @distance / 1000)
      .limit(@limit)
      .map{|s| s.as_json.merge({ "distance" => (s.distance_from(@geo_point) * 1000).to_i })}


    render json: res, status: :ok
  end

  private

  def set_params
    params.permit(:lat, :lng, :distance, :limit)

    @geo_point = [params.fetch(:lat).to_f, params.fetch(:lng).to_f]
    @limit = params.fetch(:limit, 5).to_i
    @distance = params.fetch(:distance, 500).to_i # unit: meter
  end
end

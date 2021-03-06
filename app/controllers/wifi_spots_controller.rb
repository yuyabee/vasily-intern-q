class WifiSpotsController < ApplicationController
  before_action :set_params, only: [:index]

  def index
    @filter = Filter.new(params)

    attrs = ["distance", "latitude", "longitude", "name_#{@filter.lang}", "address_#{@filter.lang}"]

    if @filter.valid?
      res = WifiSpot.search(@filter)
              .map {|s| s.as_json.merge({ "distance" => (s.distance_from(@filter.geo_point) * 1000).to_i })}
              .map {|s| s.slice(*attrs)}

      render json: res, status: :ok
    else
      render json: @filter.errors, status: :bad_request
    end
  end

  private

  def set_params
    params.permit(:lat, :lng, :distance, :limit, :lang, :search)
  end
end

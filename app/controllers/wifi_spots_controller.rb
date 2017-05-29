class WifiSpotsController < ApplicationController
  before_action :set_params, only: [:index]

  def index
    attrs = ["distance", "latitude", "longitude"]
    case @lang
    when *WifiSpot::LANG
      attrs += ["name_", "address_"].map {|attr| attr + @lang}
    else
      attrs += WifiSpot::LANG.map {|lang| ["name_" + lang, "address_" + lang]}.flatten
    end

    res = WifiSpot
      .near(@geo_point, @distance / 1000)
      .limit(@limit)
      .map {|s| s.as_json.merge({ "distance" => (s.distance_from(@geo_point) * 1000).to_i })}
      .map {|s| s.slice(*attrs)}

    render json: res, status: :ok
  end

  private

  def set_params
    params.permit(:lat, :lng, :distance, :limit, :lang, :search)

    @geo_point = params.has_key?(:search) ? params.fetch(:search) : [params.fetch(:lat).to_f, params.fetch(:lng).to_f]

    # setting default when the params not given
    @limit = params.fetch(:limit, 5).to_i
    @distance = params.fetch(:distance, 500).to_i # unit: meter

    @lang = params.fetch(:lang, "ja")
  end
end

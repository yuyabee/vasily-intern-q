class WifiSpotsController < ApplicationController
  before_action :set_params, only: [:index]

  def index
    attrs = ["distance",  "latitude", "longitude"]
    case @lang
    when "ja"
      attrs += ["name_jp", "address_jp"]
    when "en"
      attrs += ["name_en", "address_en"]
    else
      attrs += ["name_jp", "address_jp", "name_en", "address_en"]
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
    params.permit(:lat, :lng, :distance, :limit, :lang)

    @geo_point = [params.fetch(:lat).to_f, params.fetch(:lng).to_f]

    # setting default when the params not given
    @limit = params.fetch(:limit, 5).to_i
    @distance = params.fetch(:distance, 500).to_i # unit: meter

    @lang = params.fetch(:lang, nil)
  end
end

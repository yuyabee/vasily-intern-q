class Filter
  include ActiveModel::Validations

  attr_accessor :geo_point, :limit, :distance, :lang, :location, :lat, :lng

  validates :limit, numericality: { only_integer: true, greater_than: 0, less_than: 10000 }, allow_nil: true
  # less than within 100km
  validates :distance, numericality: { greater_than_or_equal_to: 0, less_than: 100000 }, allow_nil: true

  validates :lang, inclusion: { in: WifiSpot::LANG, message: "%{value} is not supported" }, allow_nil: true

  validates :lat , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }, allow_nil: true
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true

  def initialize(params)
    @geo_point = params.has_key?(:search) ? params.fetch(:search) : [params.fetch(:lat).to_f, params.fetch(:lng).to_f]

    # setting default when the params not given
    @limit = params.fetch(:limit, 5).to_i
    @distance = params.fetch(:distance, 500).to_i # unit: meter

    @lang = params.fetch(:lang, "ja")
  end
end

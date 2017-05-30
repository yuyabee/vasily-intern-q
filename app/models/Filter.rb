class Filter
  include ActiveModel::Validations

  attr_accessor :geo_point, :limit, :distance, :lang, :location, :lat, :lng

  validates :limit, numericality: { only_integer: true, greater_than: 0, less_than: 10000 }, allow_nil: true
  # within 100km
  validates :distance, numericality: { greater_than_or_equal_to: 0, less_than: 100000 }, allow_nil: true

  validates :lang, inclusion: { in: WifiSpot::LANG, message: "%{value} is not supported" }, allow_nil: true

  validates :geo_point, presence: { message: "location(string) or lat and lng must be given" }

  def initialize(params)
    if params.has_key?(:location)
      @geo_point = params.fetch(:location)
    elsif params.has_key?(:lat) && params.has_key?(:lng) 
      @geo_point = [params.fetch(:lat).to_f, params.fetch(:lng).to_f]
    end

    # setting default when the params not given
    @limit = params.fetch(:limit, 5).to_i
    @distance = params.fetch(:distance, 500).to_i / 1000 # unit: km

    @lang = params.fetch(:lang, "ja")
  end
end

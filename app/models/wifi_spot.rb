class WifiSpot < ApplicationRecord
  LANG = ["en", "ja"]

  # units: :km
  reverse_geocoded_by :latitude, :longitude

  def self.search(filter)
    near(filter.geo_point, filter.distance)
      .limit(filter.limit)
  end
end

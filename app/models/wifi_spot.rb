class WifiSpot < ApplicationRecord
  LANG = ["en", "ja"]

  # units: :km
  reverse_geocoded_by :latitude, :longitude

  def self.search(filter)
    near(filter.geo_point, filter.distance)
      .limit(filter.limit)
      .map {|s| s.as_json.merge({ "distance" => (s.distance_from(filter.geo_point) * 1000).to_i })}
  end
end

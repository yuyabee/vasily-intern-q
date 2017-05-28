class WifiSpot < ApplicationRecord
  LANG = ["en", "ja"]

  # units: :km
  reverse_geocoded_by :latitude, :longitude
end

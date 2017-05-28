class WifiSpot < ApplicationRecord
  # units: :km
  reverse_geocoded_by :latitude, :longitude
end

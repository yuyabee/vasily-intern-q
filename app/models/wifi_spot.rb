class WifiSpot < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude
end

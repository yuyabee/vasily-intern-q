# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSV.foreach("#{Rails.root}/db/jta_free_wifi.csv", {headers: true}) do |r|
  spot = WifiSpot.new(name_jp: r[1], name_en: r[2], address_jp: r[8], address_en: r[9], latitude: r[18], longitude: r[19])
  spot.save!
end

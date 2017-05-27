class CreateWifiSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :wifi_spots do |t|
      t.string :name_jp
      t.string :name_en
      t.string :address_jp
      t.string :address_en
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end

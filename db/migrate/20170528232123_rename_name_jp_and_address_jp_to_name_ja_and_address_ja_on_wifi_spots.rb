class RenameNameJpAndAddressJpToNameJaAndAddressJaOnWifiSpots < ActiveRecord::Migration[5.1]
  def change
    rename_column :wifi_spots, :name_jp, :name_ja
    rename_column :wifi_spots, :address_jp, :address_ja
  end
end

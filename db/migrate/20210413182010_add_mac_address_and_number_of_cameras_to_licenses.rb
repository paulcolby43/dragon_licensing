class AddMacAddressAndNumberOfCamerasToLicenses < ActiveRecord::Migration[6.0]
  def change
    add_column "License", :number_of_cameras, :integer
    add_column "License", :jpegger_mac_address, :string
    add_column "License", :ezcash_mac_address, :string
  end
end

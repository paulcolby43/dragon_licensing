class AddEzcashAndJpeggerFieldsToLicenses < ActiveRecord::Migration[6.0]
  def change
    add_column "License", :number_of_devices, :integer
    add_column "License", :number_of_subnets, :integer
  end
end

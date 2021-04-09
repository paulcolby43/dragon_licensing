class CreateDevicesAndCameras < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :description
      t.text :address
      t.string :license_guid

      t.timestamps
    end
    
    create_table :cameras do |t|
      t.string :name
      t.string :ip_address
      t.string :license_guid

      t.timestamps
    end
  end
end

class AddDeviseToEmployees < ActiveRecord::Migration[6.0]
  def change
    ## Database authenticatable
    add_column "Employee", :encrypted_password, :string, null: false, default: ""
    
     ## Recoverable
    add_column "Employee", :reset_password_token, :string
    add_column "Employee", :reset_password_sent_at, :datetime
    
    ## Rememberable
    add_column "Employee", :remember_created_at, :datetime
    
    ## Trackable
    add_column "Employee", :sign_in_count, :integer, null: false, default: 0
    add_column "Employee", :current_sign_in_at, :datetime
    add_column "Employee", :last_sign_in_at, :datetime
    add_column "Employee", :current_sign_in_ip, :string
    add_column "Employee", :last_sign_in_ip, :string
  end
end

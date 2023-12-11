class Customer < ApplicationRecord
  establish_connection :tranact_database
  
  has_many :devices, :foreign_key => 'CustomerID'
  belongs_to :tranact_account, foreign_key: 'Account', primary_key: 'Account', optional: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  def tranact_account
    TranactAccount.find_by(Account: self.Account)
  end
  
  def formatted_address
    "#{self.Address}, #{self.City}, #{self.State} #{self.Zip}"
  end
  
  #############################
  #     Class Methods         #
  #############################
end
class Customer < ApplicationRecord
  establish_connection :tranact_database
  
  #############################
  #     Instance Methods      #
  #############################
  
  def tranact_account
    TranactAccount.find_by(Account: self.Account)
  end
  
  #############################
  #     Class Methods         #
  #############################
end
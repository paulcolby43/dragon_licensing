class AccountActivity < ApplicationRecord
  self.table_name= 'AccountActivity'
  self.primary_key = 'Id'
  
  belongs_to :account, :foreign_key => "AccountHeadId"
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end
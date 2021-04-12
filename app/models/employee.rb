class Employee < ApplicationRecord
  self.table_name= 'Employee'
  self.primary_key = 'Id'
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end
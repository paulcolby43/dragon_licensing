class Employee < ApplicationRecord
  self.table_name= 'Employee'
  self.primary_key = 'Id'
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  
  #############################
  #     Instance Methods      #
  #############################
  
  def full_name
    "#{self.FirstName} #{self.LastName}"
  end
  
  def email
    self.Email
  end
  
  #############################
  #     Class Methods         #
  #############################
end
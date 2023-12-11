class SoftwareType < ApplicationRecord
  establish_connection :tranact_database
  self.table_name= 'SoftwareTypes'
  self.primary_key= 'SoftwareType'
  
  has_many :software_locations, :foreign_key => 'SoftwareType'
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end
class SoftwareLocation < ApplicationRecord
  establish_connection :tranact_database
  self.table_name= 'SoftwareLocations'
  
  belongs_to :tranact_account, foreign_key: 'AccountID', primary_key: 'Account', optional: true
  belongs_to :software_type, foreign_key: 'SoftwareType', optional: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end
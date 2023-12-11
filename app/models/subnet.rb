class Subnet < ApplicationRecord
  establish_connection :tranact_database
  
  belongs_to :tranact_account, foreign_key: 'AccountID', primary_key: 'Account', optional: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
end
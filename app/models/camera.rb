class Camera < ApplicationRecord
  belongs_to :license, :foreign_key => 'license_guid'
  belongs_to :account, optional: true
  
  validates :name, presence: true
  validates :ip_address, presence: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end
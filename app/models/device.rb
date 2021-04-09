class Device < ApplicationRecord
  belongs_to :license, :foreign_key => 'license_guid'
  belongs_to :account, optional: true
  
  validates :description, presence: true
  validates :address, presence: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  
  #############################
  #     Class Methods         #
  #############################
end
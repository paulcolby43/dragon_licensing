class Camera < ApplicationRecord
  belongs_to :license, :foreign_key => 'license_guid'
  belongs_to :account, optional: true
  
  validates :name, presence: true
  validates :ip_address, presence: true
  validates :license_guid, presence: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  def ip_address_as_subnet
    IPAddr.new "#{ip_address}/24"
  end
  
  #############################
  #     Class Methods         #
  #############################
end
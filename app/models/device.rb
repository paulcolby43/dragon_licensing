class Device < ApplicationRecord
  belongs_to :license, :foreign_key => 'license_guid', optional: true
  belongs_to :account, optional: true
  
  validates :description, presence: true
  validates :address, presence: true
  validates :license_guid, presence: true, on: :update
  validate :license_limit, on: :create
  
  #############################
  #     Instance Methods      #
  #############################
  
  def license_limit
    errors.add(:license, "Number of devices limit exceeded.") if license and license.devices.count >= license.number_of_devices
  end
  
  #############################
  #     Class Methods         #
  #############################
end
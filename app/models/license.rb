class License < ApplicationRecord
  self.table_name= 'License'
  self.primary_key = 'Id'
  
  belongs_to :account, :foreign_key => "AccountHeadId"
  belongs_to :software_version, :foreign_key => "SoftwareVersionId"
  has_many :devices, :foreign_key => 'license_guid'
  has_many :cameras, :foreign_key => 'license_guid'
  
  accepts_nested_attributes_for :devices, :reject_if => lambda { |d| d[:description].blank? and d[:address].blank? }, allow_destroy: true#, limit: :number_of_devices
  accepts_nested_attributes_for :cameras, :reject_if => lambda { |c| c[:name].blank? and c[:ip_address].blank? }, allow_destroy: true
  
  before_create :generate_unique_guid
  
  validate :devices_limit, on: :update
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  def as_json(options={})
    super.merge({
        'devices' => devices.empty? ? nil : devices, 
        'cameras' => cameras.empty? ? nil : cameras
      }.compact)
  end
  
  def expire_date
    self.ExpireDate
  end
  
  def days_between_update
    self.DaysBetweenUpdate
  end
  
  def auto_update?
    self.AutoUpdate
  end
  
  def is_demo_license?
    self.IsDemoLicense
  end
  
  def is_single_user?
    self.IsSingleUser
  end
  
  def generate_unique_guid
    begin
      guid = SecureRandom.uuid
      self.Id = guid
    end while self.class.exists?(Id: guid)
  end
  
  def devices_limit
    errors.add(:license, "Number of devices limit exceeded. You must first delete one or more devices, then change the number of devices limit.") if devices.count > number_of_devices
  end
  
  #############################
  #     Class Methods         #
  #############################
  
  def to_csv
    require 'csv'
    private_key = '3f~4Os^8}a5%+fRp'
    device_count = self.number_of_devices.to_s
    number_of_sites = self.number_of_subnets.to_s
    number_of_cameras = self.number_of_cameras.to_s
    name = self.account.YardName
    account_number = self.account.AccountNumber
    expire_date = self.ExpireDate.strftime('%-m/%-d/%Y')
    ezcash_mac = self.ezcash_mac_address.gsub(" ", "").strip.downcase
    ezcash_mac_converted = self.ezcash_mac_address.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
    jpegger_mac = self.jpegger_mac_address.gsub(" ", "").strip.downcase
    jpegger_mac_converted = self.jpegger_mac_address.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
    CSV.generate(headers: false, col_sep: ";") do |csv|
      
      unless number_of_devices.blank?
        # EZCash License
#        csv << ["EZCash", "#{self.number_of_devices}", "#{self.ExpireDate.strftime('%m/%d/%Y')}", "#{self.Id}"]
        csv << ["EZCash", "#{device_count}", "#{expire_date}", Digest::MD5.hexdigest('EZCash;' + name + ';' + device_count + ';' + expire_date + ';' + private_key + ';')]
        # Old EZCash Server License
        csv << ["EZDev", "#{ezcash_mac}", Digest::MD5.hexdigest('EZDev;' + name + ';' + ezcash_mac_converted + ';' + private_key + ';')]
        # New Ezcash Server License
        csv << ["EZD", "#{ezcash_mac}", "#{expire_date}", Digest::MD5.hexdigest('EZD;' + account_number + ';' + ezcash_mac_converted + ';' + expire_date + ';' + + private_key + ';')]
      end
      
      unless number_of_subnets.blank? and number_of_cameras.blank?
        # New Jpegger Server License:
        csv << ["JPD", "#{jpegger_mac}", "#{expire_date}", Digest::MD5.hexdigest('JPD;' + account_number + ';' + jpegger_mac_converted + ';' + expire_date + ';' + private_key + ';')]
        # Jpegger License
        csv << ["Jpeg", "#{number_of_sites}", "#{number_of_cameras}", "#{expire_date}", "#{jpegger_mac_converted}", Digest::MD5.hexdigest('JPeg;' + name + ';' + number_of_sites + ';' + number_of_cameras + ';' + expire_date + ';' + jpegger_mac_converted + ';' + private_key + ';')]
      end
      
    end
  end
  
end
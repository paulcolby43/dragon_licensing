class TranactAccount < ApplicationRecord
  establish_connection :tranact_database
  self.table_name= 'Accounts'
  
  has_many :customers, :foreign_key => 'Account', primary_key: 'Account'
  has_many :devices, through: :customers
  has_many :invoices, :foreign_key => 'AccountID'
  has_many :locations, :foreign_key => 'AccountID'
  has_many :software_locations, :foreign_key => 'AccountID'
  has_many :servers, foreign_key: 'AccountID'
  has_many :subnets, :foreign_key => 'AccountID'
  
  #############################
  #     Instance Methods      #
  #############################
  
  #############################
  #     Class Methods         #
  #############################
  
  def to_csv
    require 'csv'
    private_key = '3f~4Os^8}a5%+fRp'
    device_count = devices.count
    number_of_sites = subnets.count
#    number_of_cameras = self.number_of_cameras.blank? ? '0' : self.number_of_cameras.to_s
#    name = self.account.YardName unless self.account.blank?
    account_number = self.Account
    ezcash_expire_date = self.EZCashExpDate.blank? ? '' : self.EZCashExpDate.strftime('%-m/%-d/%Y')
    ezcash_mac = self.ezcash_mac_address.blank? ? '' : self.ezcash_mac_address.gsub(" ", "").strip.downcase
    ezcash_mac_converted = self.ezcash_mac_address.blank? ? '' : self.ezcash_mac_address.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
    jpegger_mac = self.jpegger_mac_address.blank? ? '' : self.jpegger_mac_address.gsub(" ", "").strip.downcase
    jpegger_mac_converted = self.jpegger_mac_address.blank? ? '' : self.jpegger_mac_address.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
    CSV.generate(headers: false, col_sep: ";", row_sep: ";\r\n") do |csv|
      
      if device_count > 0
        # EZCash License
        csv << ["EZCash", "#{device_count}", "#{ezcash_expire_date}", Digest::MD5.hexdigest('EZCash;' + self.Account + ';' + device_count + ';' + ezcash_expire_date + ';' + private_key + ';')]
      end
      unless number_of_sites == 0 #and number_of_cameras.blank?
        # New Jpegger Server License:
        csv << ["JPD", "#{jpegger_mac}", "#{expire_date}", Digest::MD5.hexdigest('JPD;' + account_number + ';' + jpegger_mac_converted + ';' + expire_date + ';' + private_key + ';')]
        # Jpegger License
#        csv << ["Jpeg", "#{number_of_sites}", "#{number_of_cameras}", "#{expire_date}", "#{jpegger_mac_converted}", Digest::MD5.hexdigest('JPeg;' + name + ';' + number_of_sites + ';' + number_of_cameras + ';' + expire_date + ';' + jpegger_mac_converted + ';' + private_key + ';')]
        csv << ["JPeg", "#{number_of_sites}", "#{number_of_cameras}", "#{expire_date}", "#{jpegger_mac_converted}", Digest::MD5.hexdigest('JPeg;' + account_number + ';' + number_of_sites + ';' + number_of_cameras + ';' + expire_date + ';' + jpegger_mac_converted + ';' + private_key + ';')]
      end
      unless number_of_devices.blank?
        # Old EZCash Server License
#        csv << ["EZDev", "#{ezcash_mac}", Digest::MD5.hexdigest('EZDev;' + name + ';' + ezcash_mac_converted + ';' + private_key + ';')]
        csv << ["EZDev", "#{ezcash_mac_converted}", Digest::MD5.hexdigest('EZDev;' + account_number + ';' + ezcash_mac_converted + ';' + private_key + ';')]
        # New Ezcash Server License
        csv << ["EZD", "#{ezcash_mac}", "12/30/1899", Digest::MD5.hexdigest('EZD;' + account_number + ';' + ezcash_mac_converted + ';' + '12/30/1899' + ';' + + private_key + ';')]
      end
    end
  end
  
end
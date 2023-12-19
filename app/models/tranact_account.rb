class TranactAccount < ApplicationRecord
  establish_connection :tranact_database
  self.table_name= 'Accounts'
  
#  has_many :customers, :foreign_key => 'Account', primary_key: 'Account'
#  has_many :devices, through: :customers
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
#    device_count = devices.count
    device_count = self.EZCashDevices.blank? ? 0 : self.EZCashDevices
    number_of_sites = self.JPEGgerQty.blank? ? 0 : self.JPEGgerQty
#    number_of_sites = servers.count
#    number_of_sites = subnets.count
#    number_of_cameras = self.number_of_cameras.blank? ? '0' : self.number_of_cameras.to_s
    account_number = self.Account
    ezcash_expire_date = self.EZCashExpDate.blank? ? '' : self.EZCashExpDate.strftime('%-m/%-d/%Y')
    jpegger_expire_date = self.JPEGgerExpDate.blank? ? '' : self.JPEGgerExpDate.strftime('%-m/%-d/%Y')
#    ezcash_mac = self.ezcash_mac_address.blank? ? '' : self.ezcash_mac_address.gsub(" ", "").strip.downcase
#    ezcash_mac_converted = self.ezcash_mac_address.blank? ? '' : self.ezcash_mac_address.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
#    jpegger_mac = self.jpegger_mac_address.blank? ? '' : self.jpegger_mac_address.gsub(" ", "").strip.downcase
#    jpegger_mac_converted = self.jpegger_mac_address.blank? ? '' : self.jpegger_mac_address.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
    CSV.generate(headers: false, col_sep: ";", row_sep: ";\r\n") do |csv|
      if device_count > 0
        # EZCash License
        csv << ["EZCash", "#{device_count}", "#{ezcash_expire_date}", Digest::MD5.hexdigest('EZCash;' + self.Account + ';' + device_count.to_s + ';' + ezcash_expire_date + ';' + private_key + ';')]
      end
      unless number_of_sites == 0 #and number_of_cameras.blank?
        jpegger_server = servers.find_by(UseForJpegger: 1)
        unless jpegger_server.blank?
          jpegger_mac = jpegger_server.MAC.blank? ? '' : jpegger_server.MAC.gsub(" ", "").strip.downcase
          jpegger_mac_converted = jpegger_server.MAC.blank? ? '' : jpegger_server.MAC.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
          number_of_cameras = 0
          # Jpegger License
          csv << ["JPeg", "#{number_of_sites}", "#{number_of_cameras}", "#{jpegger_expire_date}", "#{jpegger_mac_converted}", Digest::MD5.hexdigest('JPeg;' + account_number + ';' + number_of_sites.to_s + ';' + number_of_cameras.to_s + ';' + jpegger_expire_date + ';' + jpegger_mac_converted + ';' + private_key + ';')]
        end
      end
      unless device_count == 0
        servers.each do |server|
          ezcash_mac = server.MAC.blank? ? '' : server.MAC.gsub(" ", "").strip.downcase
          ezcash_mac_converted = server.MAC.blank? ? '' : server.MAC.gsub("-", "").gsub(" ", "").gsub(":", "").strip.downcase
          # Old EZCash Server License
  #        csv << ["EZDev", "#{ezcash_mac}", Digest::MD5.hexdigest('EZDev;' + name + ';' + ezcash_mac_converted + ';' + private_key + ';')]
          csv << ["EZDev", "#{ezcash_mac_converted}", Digest::MD5.hexdigest('EZDev;' + account_number + ';' + ezcash_mac_converted + ';' + private_key + ';')]
          # New Ezcash Server License
          csv << ["EZD", "#{ezcash_mac}", "12/30/1899", Digest::MD5.hexdigest('EZD;' + account_number + ';' + ezcash_mac_converted + ';' + '12/30/1899' + ';' + + private_key + ';')]
        end
      end
    end
  end
  
end
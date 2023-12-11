class Account < ApplicationRecord
  self.table_name= 'AccountHead'
  self.primary_key = 'Id'
  
  has_many :account_activities, :foreign_key => 'AccountHeadId'
  has_many :licenses, :foreign_key => 'AccountHeadId'
#  has_many :devices, through: :licenses
#  has_many :cameras, through: :licenses
  
  before_create :generate_unique_guid
  before_create :set_address2_to_empty_string_if_nil, if: Proc.new { |account| account.Address2.nil? }
  
  #############################
  #     Instance Methods      #
  #############################
  
  def id
    self.Id
  end
  
  def account_number
    self.AccountNumber
  end
  
  def yard_name
    self.YardName
  end
  
  def phone_number
    self.PhoneNumber
  end
  
  def address
    self.Address
  end
  
  def address_2
    self.Address2
  end
  
  def city
    self.City
  end
  
  def state
    self.State
  end
  
  def zip
    self.Zip
  end
  
  def notes
    self.Notes
  end
  
  def pretty_address
    if address_2.blank?
      "#{address}<br>#{city}, #{state} #{zip}".html_safe
    else
      "#{address}<br>#{address_2}<br>#{city}, #{state} #{zip}".html_safe
    end
  end
  
  def scrap_dragon_classic?
    self.ScrapDragonClassic
  end
  
  def scrap_dragon_x?
    self.ScrapDragonX
  end
  
  def suspended?
    self.IsSuspended
  end
  
  def active?
    self.IsActive
  end
  
  def generate_unique_guid
    begin
      guid = SecureRandom.uuid
      self.Id = guid
    end while self.class.exists?(Id: guid)
  end
  
  def set_address2_to_empty_string_if_nil
    self.Address2 = ""
  end
  
  #############################
  #     Class Methods         #
  #############################
end
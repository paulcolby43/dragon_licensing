class Account < ApplicationRecord
  self.table_name= 'AccountHead'
  self.primary_key = 'Id'
  
  has_many :account_activities, :foreign_key => 'AccountHeadId'
  has_many :licenses, :foreign_key => 'AccountHeadId'
  
  
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
  
  #############################
  #     Class Methods         #
  #############################
end
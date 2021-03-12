class License < ApplicationRecord
  self.table_name= 'License'
  self.primary_key = 'Id'
  
  belongs_to :account, :foreign_key => "AccountHeadId"
  belongs_to :software_version, :foreign_key => "SoftwareVersionId"
  
  before_create :generate_unique_guid
  
  
  #############################
  #     Instance Methods      #
  #############################
  
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
  
  #############################
  #     Class Methods         #
  #############################
end
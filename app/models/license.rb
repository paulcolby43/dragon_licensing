class License < ApplicationRecord
  self.table_name= 'License'
  self.primary_key = 'Id'
  
  belongs_to :account, :foreign_key => "AccountHeadId"
  belongs_to :software_version, :foreign_key => "SoftwareVersionId"
  
  
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
  
  #############################
  #     Class Methods         #
  #############################
end
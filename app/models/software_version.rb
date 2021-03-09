class SoftwareVersion < ApplicationRecord
  self.table_name= 'SoftwareVersion'
  self.primary_key = 'Id'
  
  has_many :licenses, :foreign_key => "SoftwareVersionId"
  
  
  #############################
  #     Instance Methods      #
  #############################
  
  def id
    self.Id
  end
  
  def name
    self.SoftwareName
  end
  
  def current_version
    self.CurrentVersion
  end
  
  def release_date
    self.ReleaseDate
  end
  
  def software_type
    self.SoftwareType
  end
  
  def is_sdx?
    self.IsSDX
  end
  
  def is_default_license?
    self.IsDefaultLicense
  end
  
  #############################
  #     Class Methods         #
  #############################
end
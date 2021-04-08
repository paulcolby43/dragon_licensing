class SoftwareVersion < ApplicationRecord
  self.table_name= 'SoftwareVersion'
  self.primary_key = 'Id'
  
  has_many :licenses, :foreign_key => "SoftwareVersionId"
  
  before_create :generate_unique_guid, :set_software_type_number
  
  validates :SoftwareType, uniqueness: true
  
  
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
  
  def generate_unique_guid
    begin
      guid = SecureRandom.uuid
      self.Id = guid
    end while self.class.exists?(Id: guid)
  end
  
  def set_software_type_number
    last_number = SoftwareVersion.maximum("SoftwareType")
    self.SoftwareType = last_number + 1
  end
  
  #############################
  #     Class Methods         #
  #############################
end
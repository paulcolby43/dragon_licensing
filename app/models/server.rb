class Server < ApplicationRecord
  establish_connection :tranact_database
  
  belongs_to :tranact_account, foreign_key: 'AccountID', optional: true
  
  before_create :set_create_date
  before_update :set_modified_date
  
  validates :Name, presence: true, uniqueness: true
  validates :MAC, presence: true, uniqueness: true
  
  #############################
  #     Instance Methods      #
  #############################
  
  
  #############################
  #     Class Methods         #
  #############################
  
  private

  def set_create_date
    self.CreateDate = Time.current if self.CreateDate.nil?
  end
  
  def set_modified_date
    self.ModifiedDate = Time.current
  end
  
end
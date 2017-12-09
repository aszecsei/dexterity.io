class Status < ApplicationRecord
  
  resort!
  
  belongs_to :project
  
  has_many :issues
  
  validates_presence_of :name
  validates_presence_of :project_id
  validates_presence_of :category
  
  def siblings
    self.project.statuses
  end
end

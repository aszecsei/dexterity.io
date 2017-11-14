class Status < ApplicationRecord
  belongs_to :project
  
  has_many :issues
  
  validates_presence_of :name
  validates_presence_of :project_id
  validates_presence_of :category
  
end

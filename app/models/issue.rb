class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :status
  belongs_to :category
  
  validates_presence_of :name
  
  attribute :estimated_time, :duration
  
  has_many :assigned_to, :through => :assignments
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  belongs_to :blocked_by, class_name: 'Issue', foreign_key: :blocked_by_id, optional: true
  
  has_many :blocking, foreign_key: "blocked_by", class_name: "Issue"
end

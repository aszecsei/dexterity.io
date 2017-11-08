class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :status
  belongs_to :category
  
  attribute :estimated_time, :duration
  
  belongs_to :assigned_to, class_name: 'User', foreign_key: :assigned_to
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by
  belongs_to :blocked_by, class_name: 'Issue', foreign_key: :blocked_by
  
  has_many :blocking, foreign_key: "blocked_by", class_name: "Issue"
end

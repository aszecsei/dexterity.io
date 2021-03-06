class Issue < ApplicationRecord

  resort!
  
  belongs_to :project
  belongs_to :status
  belongs_to :category
  
  validates_presence_of :name
  
  def estimated_time_string
    ChronicDuration.output(270, :format => :short)
  end
  
  has_many :assignments
  has_many :assigned_to, :through => :assignments
  
  has_many :activitylogs
  
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  
  has_many :blockages
  has_many :blocked_issues, :through => :blockages
  
  has_many :blockers, foreign_key: :blocked_issue_id, class_name: 'Blockage'
  has_many :blocked_by, through: :blockers, source: :issue
  
  def siblings
    self.status.issues
  end
end

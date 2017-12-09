class Activitylog < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  
  def isIssueStartWork
    return (activity_type == "In Progress")
  end
  
  def isIssueClose
    return (activity_type == "Done")
  end
  
  def isIssueOpen
    return (activity_type == "To Do")
  end
end

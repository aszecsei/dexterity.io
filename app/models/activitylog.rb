class Activitylog < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  
  def isIssueStartWork
    return (type == "In Progress")
  end
  
  def isIssueClose
    return (type == "Done")
  end
  
  def isIssueOpen
    return (type == "To Do")
  end
end

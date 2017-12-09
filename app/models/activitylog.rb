class Activitylog < ApplicationRecord
  belongs_to :issue
  
  def isIssueClose
    return (type == "CLOSE")
  end
  
  def isIssueOpen
    return (type == "OPEN")
  end
end

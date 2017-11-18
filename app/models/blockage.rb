class Blockage < ApplicationRecord
  belongs_to :issue
  belongs_to :blocked_issue, class_name: 'Issue'
end

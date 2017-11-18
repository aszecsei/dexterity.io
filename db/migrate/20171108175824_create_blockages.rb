class CreateBlockages < ActiveRecord::Migration[5.1]
  def change
    create_table :blockages do |t|
      t.timestamps
      
      t.belongs_to :issue
      t.belongs_to :blocked_issue
      
      t.index [:issue_id, :blocked_issue_id], unique: true
    end
  end
end

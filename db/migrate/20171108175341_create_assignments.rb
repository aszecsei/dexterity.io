class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.timestamps
      
      t.belongs_to :user
      t.belongs_to :issue

      t.index [:user_id, :issue_id], unique: true
    end
  end
end

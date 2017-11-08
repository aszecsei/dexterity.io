class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :name, :null => false
      t.string :description
      t.references :status, foreign_key: true, :null => false
      t.references :category, foreign_key: true, :null => false
      t.references :project, foreign_key: true, :null => false
      
      t.references :assigned_to, foreign_key: { to_table: :users }
      t.references :created_by, foreign_key: { to_table: :users }, :null => false
      
      t.references :blocked_by, foreign_key: { to_table: :issues }
      
      t.string :estimated_time
      t.integer :story_points

      t.timestamps
    end
  end
end

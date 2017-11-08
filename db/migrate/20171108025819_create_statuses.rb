class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :name, :null => false
      t.string :description
      t.string :category, :null => false, :default => "To Do"
      t.references :project, :null => false, foreign_key: true

      t.timestamps
    end
  end
end

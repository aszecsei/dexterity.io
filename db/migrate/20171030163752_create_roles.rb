class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name, :null => false
      t.references 'project', :null => false
      t.boolean :add_issues, :default => false
      t.boolean :close_issues, :default => false
      t.boolean :assign_issues, :default => false
      t.boolean :edit_project, :default => false
      t.boolean :delete_project, :default => false
      t.boolean :add_project_members, :default => false
      t.boolean :remove_project_members, :default => false
      t.timestamps
    end
  end
end

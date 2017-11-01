class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.references 'project'
      t.boolean :add_issues
      t.boolean :close_issues
      t.boolean :assign_issues
      t.boolean :edit_project
      t.boolean :delete_project
      t.boolean :add_project_members
      t.boolean :remove_project_members
      t.timestamps
    end
  end
end

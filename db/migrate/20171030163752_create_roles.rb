class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.references 'project'
      t.binary :add_issues
      t.binary :close_issues
      t.binary :assign_issues
      t.binary :edit_project
      t.binary :delete_project
      t.binary :add_project_members
      t.binary :remove_project_members
      t.timestamps
    end
  end
end

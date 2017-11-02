class Changenullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :roles, :name, false
    change_column_null :roles, :project_id, false
    change_column_default :roles, :add_issues, false
    change_column_default :roles, :close_issues, false
    change_column_default :roles, :assign_issues, false
    change_column_default :roles, :edit_project, false
    change_column_default :roles, :delete_project, false
    change_column_default :roles, :add_project_members, false
    change_column_default :roles, :remove_project_members, false
  end
end

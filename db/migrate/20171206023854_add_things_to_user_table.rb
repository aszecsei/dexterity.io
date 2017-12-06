class AddThingsToUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :github, :boolean, default: false
    add_column :users, :github_username, :string
  end
end

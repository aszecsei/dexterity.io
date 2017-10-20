class CreateUserDatabases < ActiveRecord::Migration[5.1]
  def change
    create_table :user_databases do |t|
      t.string :username, :null => false, unique: true
      t.string :email, :null => false, unique: true
      t.string :displayName
      t.string :password
      t.timestamps
    end
  end
end

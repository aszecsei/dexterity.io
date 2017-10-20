class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, :null => false, unique: true
      t.string :email, :null => false, unique: true
      t.string :displayName
      t.string :password_digest
      t.string :token
      t.timestamps
    end
  end
end

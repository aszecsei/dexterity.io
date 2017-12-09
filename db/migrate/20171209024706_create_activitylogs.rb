class CreateActivitylogs < ActiveRecord::Migration[5.1]
  def change
    create_table :activitylogs do |t|
      t.string :type
      t.string :description
      t.references :issue, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

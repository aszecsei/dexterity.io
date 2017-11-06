class CreateWorkingons < ActiveRecord::Migration[5.1]
  def change
    create_table :workingons do |t|
      t.references 'project'
      t.references 'user'
      t.references 'role'
      t.timestamps
    end
  end
end

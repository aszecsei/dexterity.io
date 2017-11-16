# Migration to add the necessary fields to a resorted model
class AddResortFieldsToStatuses < ActiveRecord::Migration[5.1]
  # Adds Resort fields, next_id and first, and indexes to a given model
  def self.up
    add_column :statuses, :next_id, :integer
    add_column :statuses, :first,   :boolean
    add_index :statuses, :next_id
    add_index :statuses, :first
  end

  # Removes Resort fields
  def self.down
    remove_column :statuses, :next_id
    remove_column :statuses, :first
  end
end


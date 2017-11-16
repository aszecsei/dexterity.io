# Migration to add the necessary fields to a resorted model
class AddResortFieldsToIssues < ActiveRecord::Migration[5.1]
  # Adds Resort fields, next_id and first, and indexes to a given model
  def self.up
    add_column :issues, :next_id, :integer
    add_column :issues, :first,   :boolean
    add_index :issues, :next_id
    add_index :issues, :first
  end

  # Removes Resort fields
  def self.down
    remove_column :issues, :next_id
    remove_column :issues, :first
  end
end


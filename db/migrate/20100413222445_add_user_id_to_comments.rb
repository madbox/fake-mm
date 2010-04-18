class AddUserIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :comments, :user_id
  end
end

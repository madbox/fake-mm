class AddAboutToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :about, :text, :default => '', :null => false
    add_column :users, :birthday, :datetime
    add_column :users, :gender, :string
    add_column :users, :city, :string
  end

  def self.down
    remove_column :users, :about
  end
end

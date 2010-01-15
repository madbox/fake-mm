class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :sysname, :null => false
      t.boolean :public, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end

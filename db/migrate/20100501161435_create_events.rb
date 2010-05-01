class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :date, :null => false
      t.string :title, :default => '', :null => false
      t.text :text, :default => '', :null => false
      t.string :artist, :null => false
      t.string :city, :default => '', :null => false
      t.float :price, :null => false, :default => 0.0
      t.string :club, :default => '', :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end

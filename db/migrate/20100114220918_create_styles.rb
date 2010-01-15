class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.string :name, :null => false
      t.string :template, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :styles
  end
end

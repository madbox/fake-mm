class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :sysname, :null => false
      t.string :name, :null => false

      t.boolean :public, :null => false, :default => false

      t.text :description, :default => '', :null => false

      t.integer :user_id, :default => nil

      t.string :custom_author, :default => ''
      t.string :custom_author_link, :default => ''
      t.string :photographer, :default => ''
      t.string :photographer_link, :default => ''

      t.string :imagemh_file_name
      t.string :imagemh_content_type
      t.integer :imagemh_file_size
      t.datetime :imagemh_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end

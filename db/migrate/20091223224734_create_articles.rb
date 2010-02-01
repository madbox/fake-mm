class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :sysname, :null => false

      t.string :title, :null => false
      t.string :custom_author, :default => ''
      t.string :custom_author_link, :default => ''
      t.string :photographer, :default => ''
      t.string :photographer_link, :default => ''
      t.string :source, :default => ''
      t.string :source_link, :default => ''
      t.text :content, :null => false
      t.text :description, :default => ''
      t.text :internal_comment, :default => ''
      
      t.text :meta_keywords, :default => ''
      t.text :meta_description, :default => ''

      t.integer :user_id, :null => false
      t.integer :style_id # тип статьи
      t.integer :category_id # тип статьи

      t.integer :views_count, :default => 0
      t.integer :importance, :default => 0

      t.timestamps
      t.boolean :published, :default => false
      t.boolean :draft, :default => true
      t.datetime :publish_date

      # paperclip
      t.string :imagebh_file_name
      t.string :imagebh_content_type
      t.integer :imagebh_file_size
      t.datetime :imagebh_updated_at

      t.string :imagebv_file_name
      t.string :imagebv_content_type
      t.integer :imagebv_file_size
      t.datetime :imagebv_updated_at

      t.string :imagemh_file_name
      t.string :imagemh_content_type
      t.integer :imagemh_file_size
      t.datetime :imagemh_updated_at

      t.string :imagemv_file_name
      t.string :imagemv_content_type
      t.integer :imagemv_file_size
      t.datetime :imagemv_updated_at

      t.string :imagemm_file_name
      t.string :imagemm_content_type
      t.integer :imagemm_file_size
      t.datetime :imagemm_updated_at

    end
  end

  def self.down
    drop_table :articles
  end
end

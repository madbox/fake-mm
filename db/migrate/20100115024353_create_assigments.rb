class CreateAssigments < ActiveRecord::Migration
  def self.up
    create_table :assigments, :id => false do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :assigments
  end
end

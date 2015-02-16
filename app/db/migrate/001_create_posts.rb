class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |table|
      table.integer :user_id, null: false
      table.string  :title, null: false
      table.integer :trip_id, null: true
    end
  end
end

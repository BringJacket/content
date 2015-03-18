class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |table|
      table.string  :user, null: false
      table.string  :title, null: false
      table.integer :trip_id, null: true
      table.text    :geometry, null: false
      table.text    :body, null: true
      table.string  :photo, null: true

      table.timestamps null: false
    end
  end
end

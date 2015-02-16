class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |table|
      table.integer :user_id, null: false
      table.string  :title, null: false
    end
  end
end

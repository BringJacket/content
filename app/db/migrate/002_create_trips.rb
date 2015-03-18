class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |table|
      table.string  :user, null: false
      table.string  :title, null: false
      table.text    :summary, null: true
      table.text    :geometry, null: true
      table.boolean :ongoing, null: false, default: true

      table.timestamps null: false
    end
  end
end

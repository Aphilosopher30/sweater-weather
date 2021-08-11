class CreateRoadTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :road_trips do |t|
      t.string :start_city
      t.string :end_city

      t.timestamps
    end
  end
end

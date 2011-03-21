class CreateJourneyLocations < ActiveRecord::Migration
  def self.up
    create_table :journey_locations do |t|
      t.integer  "vehicle_journey_id"
      t.integer  "service_id"
      t.integer  "route_id"
      t.datetime "reported_time"
      t.datetime "recorded_time"
      t.text     "coordinates"

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_locations
  end
end

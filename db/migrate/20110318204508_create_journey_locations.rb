class CreateJourneyLocations < ActiveRecord::Migration
  def self.up
    create_table :journey_locations do |t|
      t.integer  "vehicle_journey_id"
      t.integer  "service_id"
      t.integer  "route_id"
      t.datetime "reported_time"
      t.datetime "recorded_time"
      t.float    "direction"
      t.integer  "distance" # feet
      t.text     "coordinates"
      t.integer  "timediff" # seconds
      t.text     "last_coordinates"
      t.datetime "last_reported_time"
      t.integer  "last_distance"
      t.float    "last_direction"
      t.integer  "last_timediff"

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_locations
  end
end

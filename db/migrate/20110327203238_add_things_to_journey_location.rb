class AddThingsToJourneyLocation < ActiveRecord::Migration
  def self.up
    change_table :journey_locations do |t|
      t.float    "direction"
      t.integer  "distance" # feet
      t.integer  "timediff" # seconds
      t.text     "last_coordinates"
      t.datetime "last_reported_time"
      t.integer  "last_distance"
      t.float    "last_direction"
      t.integer  "last_timediff"
    end
  end

  def self.down
  end
end

class CreateVehicleJourneys < ActiveRecord::Migration
  def self.up
    create_table :vehicle_journeys do |t|
      t.string  "name"
      t.string  "description"
      t.integer "service_id"
      t.integer "journey_pattern_id"
      t.integer "departure_time"
      t.string  "display_name"
      t.integer "persistentid"

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicle_journeys
  end
end

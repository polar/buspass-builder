class CreateStopPoints < ActiveRecord::Migration
  def self.up
    create_table :stop_points do |t|
      t.integer  "code"
      t.string   "common_name"
      t.string   "street_name"
      t.string   "locality_name"
      t.string   "description"
      t.integer  "location_id"
      t.integer  "network_version_id"

      t.timestamps
    end
  end

  def self.down
    drop_table :stop_points
  end
end

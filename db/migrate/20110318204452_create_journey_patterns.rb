class CreateJourneyPatterns < ActiveRecord::Migration
  def self.up
    create_table :journey_patterns do |t|
      t.string   "name"
      t.string   "description"
      t.integer  "route_id"
      t.float    "nw_lat"
      t.float    "nw_lon"
      t.float    "se_lat"
      t.float    "se_lon"
      t.integer  "service_id"

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_patterns
  end
end

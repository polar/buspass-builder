class CreateJourneyPatternTimingLinks < ActiveRecord::Migration
  def self.up
    create_table :journey_pattern_timing_links do |t|
      t.integer  "journey_pattern_id"
      t.integer  "position"
      t.float    "nw_lat"
      t.float    "nw_lon"
      t.float    "se_lat"
      t.float    "se_lon"
      t.string   "name"
      t.integer  "to_id"
      t.integer  "from_id"
      t.integer  "time"
      t.text     "google_uri"
      t.text     "view_path_coordinates"

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_pattern_timing_links
  end
end

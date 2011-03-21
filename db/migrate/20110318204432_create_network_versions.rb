class CreateNetworkVersions < ActiveRecord::Migration
  def self.up
    create_table :network_versions do |t|
      t.integer  "version"
      t.string   "name"
      t.datetime "start_date"
      t.datetime "end_date"

      t.timestamps
    end
  end

  def self.down
    drop_table :network_versions
  end
end

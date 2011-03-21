class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string   "name"
      t.string   "code"
      t.string   "description"
      t.integer  "network_version_id"
      t.string   "display_name"
      t.integer  "persistentid"

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end

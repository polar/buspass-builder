class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string   "name"
      t.string   "description", :default => ""
      t.text     "coordinates"

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end

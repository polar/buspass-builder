class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string   "name"
      t.string   "persistentid"
      t.string   "description"
      t.date     "operating_period_start_date"
      t.date     "operating_period_end_date"
      t.boolean  "monday"
      t.boolean  "tuesday"
      t.boolean  "wednesday"
      t.boolean  "thursday"
      t.boolean  "friday"
      t.boolean  "saturday"
      t.boolean  "sunday"
      t.integer  "direction_id"
      t.integer  "route_id"
      t.string   "day_class"

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end

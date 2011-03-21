class CreateUserTrackings < ActiveRecord::Migration
  def self.up
    create_table :user_trackings do |t|
      t.float    "longitude"
      t.float    "latitude"
      t.datetime "login_date"
      t.integer  "user_id"

      t.timestamps
    end
  end

  def self.down
    drop_table :user_trackings
  end
end

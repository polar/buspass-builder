class CreateApis < ActiveRecord::Migration
  def self.up
    create_table :apis do |t|
      t.integer  "major_version"
      t.integer  "minor_version"
      t.text     "definition"

      t.timestamps
    end
  end

  def self.down
    drop_table :apis
  end
end

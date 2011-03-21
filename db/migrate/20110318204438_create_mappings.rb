class CreateMappings < ActiveRecord::Migration
  def self.up
    create_table :mappings do |t|
      t.string   "name"
      t.string   "description"

      t.timestamps
    end
  end

  def self.down
    drop_table :mappings
  end
end

class CreateDirections < ActiveRecord::Migration
  def self.up
    create_table :directions do |t|
      t.string "name"
      t.string "description"

      t.timestamps
    end
  end

  def self.down
    drop_table :directions
  end
end

class CreateGoogleUriViewPaths < ActiveRecord::Migration
  def self.up
    create_table :google_uri_view_paths do |t|
      t.text     "uri"
      t.text     "view_path_coordinates"

      t.timestamps
    end
  end

  def self.down
    drop_table :google_uri_view_paths
  end
end

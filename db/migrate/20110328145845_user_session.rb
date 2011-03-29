class UserSession < ActiveRecord::Migration
  def self.up
   change_table :user_trackings do |t|
    t.integer :sessionid
   end
  end

  def self.down
  end
end

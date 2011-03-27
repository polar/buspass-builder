class CreateCallStats < ActiveRecord::Migration
  def self.up
    create_table :call_stats, :force => true do |t|
      t.references :user
      t.float      :longitude
      t.float      :latitude
      t.string     :controller
      t.string     :action
      t.datetime   :call_time
      t.datetime   :recv_time
      t.datetime   :send_time
      t.integer    :sessionid

      t.timestamps
    end
  end

  def self.down
    drop_table :call_stats
  end
end

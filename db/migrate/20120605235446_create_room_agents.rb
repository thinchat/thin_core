class CreateRoomAgents < ActiveRecord::Migration
  def change
    create_table :room_agents do |t|
      t.integer :room_id
      t.integer :thin_auth_id
      t.timestamps
    end
  end
end

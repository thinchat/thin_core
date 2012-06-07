class DestroySpike < ActiveRecord::Migration
  def change
    drop_table :room_agents
    drop_table :agents

    add_column :messages, :user_id, :integer
    add_column :messages, :user_type, :string
    add_column :messages, :user_name, :string
  end
end

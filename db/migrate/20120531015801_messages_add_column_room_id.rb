class MessagesAddColumnRoomId < ActiveRecord::Migration
  def change
    add_column :messages, :room_id, :integer
  end
end

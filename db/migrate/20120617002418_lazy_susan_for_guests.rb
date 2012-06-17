class LazySusanForGuests < ActiveRecord::Migration
  def change
    add_index :guests, :id
    add_index :messages, :id
    add_index :messages, :room_id
    add_index :messages, :user_id
    add_index :messages, [:room_id, :user_id]
    add_index :messages, [:user_id, :room_id]
    add_index :rooms, :id
    add_index :rooms, :guest_id
  end
end

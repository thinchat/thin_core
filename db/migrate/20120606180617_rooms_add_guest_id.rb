class RoomsAddGuestId < ActiveRecord::Migration
  def change
    add_column :rooms, :guest_id, :integer
  end
end

class RoomsRemoveColumnGuestId < ActiveRecord::Migration
  def change
    remove_column :rooms, :guest_id
  end
end

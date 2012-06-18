class RoomsAddIndexOnStatus < ActiveRecord::Migration
  def change
    add_index :rooms, :status
  end
end

class MessagesAddColumnThinAuthId < ActiveRecord::Migration
  def change
    add_column :messages, :thin_auth_id, :integer
  end
end

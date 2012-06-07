class MessagesRemoveColumnThinAuthId < ActiveRecord::Migration
  def change
    remove_column :messages, :thin_auth_id
  end
end

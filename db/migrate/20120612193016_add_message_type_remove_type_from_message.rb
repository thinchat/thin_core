class AddMessageTypeRemoveTypeFromMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :type
    add_column :messages, :message_type, :string
  end
end

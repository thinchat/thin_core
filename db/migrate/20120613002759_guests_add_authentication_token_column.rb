class GuestsAddAuthenticationTokenColumn < ActiveRecord::Migration
  def change
    add_column :guests, :authentication_token, :string
  end
end

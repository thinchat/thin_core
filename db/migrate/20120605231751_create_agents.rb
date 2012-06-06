class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.integer :thin_auth_id

      t.timestamps
    end
  end
end

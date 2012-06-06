class RoomAgents < ActiveRecord::Base
  attr_accessible :thin_auth_id, :room_id, :room

  belongs_to :room
  belongs_to :agent, :through => :thin_auth_id
end

class RoomAgent < ActiveRecord::Base
  attr_accessible :thin_auth_id, :room_id, :room

  belongs_to :agent, :foreign_key => :thin_auth_id
  belongs_to :room
  
end
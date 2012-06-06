class Room < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :room_agents, :foreign_key => :thin_auth_id
  has_many :agents, :through => :room_agents

  has_many :messages
end

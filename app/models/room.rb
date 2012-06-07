class Room < ActiveRecord::Base
  attr_accessible :name, :guest
  validates_presence_of :name
  has_many :room_agents
  has_many :agents, :through => :room_agents
  belongs_to :guest

  has_many :messages

end

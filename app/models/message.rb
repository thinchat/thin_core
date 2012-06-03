class Message < ActiveRecord::Base
  attr_accessible :body, :room_id
  validates_length_of :body, :maximum => 1000
  validates_presence_of :room_id, :body

  belongs_to :room
end

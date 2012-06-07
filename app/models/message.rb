class Message < ActiveRecord::Base
  attr_accessible :body, :room_id, :user_id, :user_type, :user_name
  validates_length_of :body, :maximum => 1000
  validates_presence_of :room_id, :body

  belongs_to :room

end
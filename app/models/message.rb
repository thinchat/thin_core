class Message < ActiveRecord::Base
  attr_accessible :body, :room_id, :thin_auth_id
  validates_length_of :body, :maximum => 1000
  validates_presence_of :room_id, :body


  belongs_to :room

  def display_name
    return "Guest" unless thin_auth_id
    Agent.where(thin_auth_id: thin_auth_id.to_s).first.name
  end

end
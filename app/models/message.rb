class Message < ActiveRecord::Base
  attr_accessible :body, :room_id, :user_id, :user_type, :user_name
  validates_length_of :body, :maximum => 1000
  validates_presence_of :room_id, :body

  belongs_to :room

  def to_hash
    {
      room_id: room_id,
      user_name: user_name,
      user_id: user_id,
      user_type: user_type,
      message_id: id,
      message_type: self.class.name,
      message_body: body,
      metadata: { },
      created_at: created_at,
    }
  end

end
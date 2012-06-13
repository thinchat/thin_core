class Message < ActiveRecord::Base
  attr_accessible :body, :room_id, :user_id, :user_type, :user_name, :message_type, :metadata

  validates_length_of :body, :maximum => 1000
  validates_presence_of :room_id, :body

  store :metadata

  belongs_to :room

  def to_hash
    {
      room_id: room_id,
      user_name: user_name,
      user_id: user_id,
      user_type: user_type,
      message_id: id,
      message_type: message_type,
      message_body: body,
      metadata: metadata,
      created_at: created_at,
    }
  end

  def channel
    "/messages/#{room_id}"
  end

  def faye_message
    { :channel => channel,
      :data    => { :chat_message => to_hash } }
  end

  def broadcast
    publish_to_faye
    publish_to_redis
  end

  def publish_to_faye
    uri = URI.parse("#{FAYE_URL}/faye")
    Net::HTTP.post_form(uri, :message => faye_message.to_json)
  end

  def publish_to_redis
    REDIS.publish 'thinchat', faye_message.to_json
  end
end
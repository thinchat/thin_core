class Message < ActiveRecord::Base
  MESSAGE_ATTRS = [ :body, :room_id, :user_id, :user_type, :user_name, :message_type, :metadata ]
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

  def self.build_params_hash(json)
    params = JSON.parse(json)
    hash = {}
    MESSAGE_ATTRS.each do |attribute|
      hash[attribute] = params[attribute.to_s] if params.has_key? attribute.to_s
    end
    hash[:room_id] = params["location"]
    hash[:metadata] = {client_id: params["client_id"], location: params["location"]}
    hash
  end

  def in_chat_room?
    room_id > 0
  end

  def room_channel
    "/messages/#{room_id}" if in_chat_room?
  end

  def online_user_channel
    "/online_users"
  end

  def faye_message
    { :channel => room_channel,
      :data    => { :chat_message => to_hash } }
  end

  def broadcast
    publish_to_faye && publish_to_redis
  end

  def get_channels
    case message_type
    when "Subscribe", "Disconnect"
      [ online_user_channel, room_channel ].delete_if{ |x| x.nil? }
    else
      [ room_channel ]
    end
  end

  def publish_to_faye
    messenger = Messenger.new("#{FAYE_URL}/faye")
    messenger.publish(get_channels, to_hash)
  end

  def publish_to_redis
    REDIS.publish 'thinchat', faye_message.to_json
  end
end
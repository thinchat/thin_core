class Message < ActiveRecord::Base
  MESSAGE_ATTRS = [ :body, :room_id, :user_id, :user_type, :user_name, :message_type, :metadata ]
  attr_accessible :body, :room_id, :user_id, :user_type, :user_name, :message_type, :metadata
  validates_length_of :body, :maximum => 1000
  validates_presence_of :room_id, :body
  store :metadata
  belongs_to :room

  def to_hash
    hash = { room_id: room_id,
             user_name: user_name,
             user_id: user_id,
             user_type: user_type,
             message_id: id,
             message_type: message_type,
             message_body: body,
             metadata: metadata,
             created_at: created_at,
             pretty_time: pretty_time }
  end

  def pretty_time
    created_at.strftime("%l:%M %p") if created_at
  end

  def self.build_params_hash(params)
    params = JSON.parse(params)
    hash = {}
    MESSAGE_ATTRS.each do |attribute|
      hash[attribute] = params[attribute.to_s] if params.has_key? attribute.to_s
    end
    add_room_id(hash, params)
    add_metadata(hash, params)
  end

  def self.add_room_id(hash, params)
    room = Room.find_by_name(params["location"]) if params.has_key? "location"
    hash.tap do |h|
      hash[:room_id] = room ? room.id : 0
    end
    #faye_server sends location, for Lobby. thin_file sends as room_id, for message.
  end

  def self.add_metadata(hash, params)
    hash[:metadata] ||= {}
    hash.tap do |h|
      h[:metadata].merge!({client_id: params["client_id"], location: params["location"]})
    end
  end

  def in_room?
    room_id != 0
  end

  def from_agent?
    user_type == "Agent"
  end

  def from_guest?
    user_type == "Guest"
  end

  def room_channel
    room = Room.where(id: room_id).first
    room.present? ? "/messages/#{room.name}" : nil
  end

  def online_user_channel
    user_type ? "/online/#{user_type.downcase}" : "/online"
  end

  def get_channels
    case message_type
    when "Subscribe", "Disconnect"
      [ online_user_channel, room_channel ].delete_if{ |x| x.nil? }
    else
      [ room_channel ]
    end
  end

  def broadcast
    publish_to_faye && publish_to_redis
  end

  def publish_to_faye
    messenger = Messenger.new("#{FAYE_URL}/faye")
    messenger.publish(get_channels, to_hash)
  end

  def publish_to_redis
    messenger = RedisMessenger.new('localhost', 6379)
    messenger.publish(to_hash)
  end
end
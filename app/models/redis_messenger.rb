class RedisMessenger
  attr_accessor :client

  def initialize
    @client = $redis
  end

  def publish(hash, channels = nil)
    channels = get_channels(channels)
    channels.uniq.each do |channel|
      client.publish channel, message(hash).to_json
    end
  end

  def get_channels(channels)
    if channels.nil?
      channels = [redis_channel]
    elsif channels.is_a? String
      channels = [channels]
    else
      channels
    end
  end

  def redis_channel
    "thinchat"
  end

  def message(hash)
    { :data => { :chat_message => hash } }
  end
end

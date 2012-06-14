class Messenger
  attr_accessor :uri

  def initialize(url)
    @uri = URI.parse(url)
  end

  def publish(channels, hash)
    channels = [channels] if channels.is_a? String
    channels.uniq.each do |channel|
      Net::HTTP.post_form(uri, :message => message(channel, hash).to_json)
    end
  end

  def message(channel, hash)
    { :channel => channel,
      :data    => { :chat_message => hash } }
  end
end

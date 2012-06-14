class Alert
  def self.notify_agent(requesting_agent, requested_agent, room_url)
    messenger = Messenger.new("#{FAYE_URL}/faye")
    messenger.publish(requested_agent.channel, build_message_hash(requesting_agent, room_url))
  end

  def self.build_message_hash(requesting_agent, room_url)
    { message_body: "#{requesting_agent.user_name} has requested you in #{requesting_agent.location}.",
      location: room_url }
  end
end
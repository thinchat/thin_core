require 'hashie'

class Client
  attr_accessor :display_name, :room, :id

  def initialize(message)
    @display_name = message.display_name
    @room = message.room
    @client_id = message.client_id
  end
end

class FayeMessage
  attr_accessor :message, :client

  def initialize(message)
    @message = Hashie::Mash.new(message)
  end

  def client_id
    message.clientId
  end

  def action
    message.channel.split('/').last if message.channel
  end

  def display_name
    message.ext.display_name if message.ext
  end

  def room
    message.subscription
  end

  def client
    @client ||= Client.new(self)
  end

  def build_hash(client=nil)
    message_hash = { 'type' => action }

    if action == 'subscribe'
      message_hash['object'] = { 'body' => "#{client.display_name} entered."}
    elsif action == 'disconnect'
      message_hash['object'] = { 'body' => "#{client.display_name} left." }
    end

    message_hash
  end
end

class ClientEvent
  MONITORED_CHANNELS = [ '/meta/subscribe', '/meta/disconnect' ]

  def incoming(message, callback)
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']

    faye_message = FayeMessage.new(message)

    if client = get_client(faye_message)
      faye_client.publish(client.room, faye_message.build_hash(client))
    end
    callback.call(message)
  end

  def get_client(message)
    if message.action == 'subscribe'
      push_client(message.client)
    elsif message.action == 'disconnect'
      pop_client(message.client)
    end
  end

  def push_client(client)
    connected_clients[client.id] = client
  end

  def pop_client(client)
    connected_clients.delete(client.id)
  end

  def connected_clients
    @connected_clients ||= { }
  end

  def faye_client
    @faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
end
require 'hashie'

class Client
  attr_accessor :display_name, :room

  def initialize(display_name, room)
    @display_name = display_name
    @room = room
  end
end

class FayeMessage
  attr_accessor :message, :client

  def initialize(message)
    @message = Hashie::Mash.new(message)
    @client = Client.new(display_name, room)
  end

  def id
    message.clientId
  end

  def action
    message.channel.split('/').last
  end

  def display_name
    message.ext.display_name
  end

  def room
    message.subscription
  end
end

class ClientEvent
  MONITORED_CHANNELS = [ '/meta/subscribe', '/meta/disconnect' ]

  def incoming(message, callback)
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']

    fayemessage = FayeMessage.new(message)
    puts fayemessage.inspect

    if client = get_client(message)
      message_hash = build_message_hash(client, message)
      faye_client.publish(client.room, message_hash)
    end
    callback.call(message)
  end

  def get_client(message)
    id = get_id(message)
    action = get_action(message)

    if action == 'subscribe'
      push_client(id, message)
    elsif action == 'disconnect'
      pop_client(id)
    end
  end

  def get_id(message)
    message['clientId']
  end

  def get_action(message)
    message['channel'].split('/').last
  end

  def push_client(client_id, message)
    client = Client.new(message['ext']['display_name'], message['subscription'])
    connected_clients[client_id] = client
  end

  def pop_client(client_id)
    connected_clients.delete(client_id)
  end

  def build_message_hash(client, message)
    type = get_action(message)
    message_hash = { 'type' => type }
    if type == 'subscribe'
      message_hash['object'] = {'body' => "#{client.display_name} entered."}
    elsif type == 'disconnect'
      message_hash['object'] = {'body' => "#{client.display_name} left."}
    end
    message_hash
  end

  def connected_clients
    @connected_clients ||= { }
  end

  def faye_client
    @faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
end
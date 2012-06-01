require 'faye'
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
Faye::WebSocket.load_adapter('thin')

# class UserEnter
#   def incoming(message, callback)
#     # Let non-subscribe messages through
#     unless message['channel'] == '/meta/subscribe'
#       return callback.call(message)
#     end

#     client = Faye::Client.new('http://localhost:9292/faye')
#     client.publish('/messages/3', 'text' => 'Hello world')

#     # Call the server back now we're done
#     callback.call(message)
#   end
# end

# faye_server.add_extension(UserEnter.new)
faye_server.bind(:subscribe) do |client_id, channel|
  puts "SUBSCRIBED!"
  client = Faye::Client.new('http://localhost:9292/faye')
  client.publish(channel, { 'type' => 'subscribe', 'body' => 'User entered.' })
end

faye_server.bind(:unsubscribe) do |client_id, channel|
  puts "UNSUBSCRIBED!"
  client = Faye::Client.new('http://localhost:9292/faye')
  client.publish(channel, { 'type' => 'unsubscribe', 'body' => 'User left.' })
end

run faye_server
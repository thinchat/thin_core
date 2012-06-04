require 'faye'
load 'faye/client_event.rb'

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
Faye::WebSocket.load_adapter('thin')

faye_server.add_extension(ClientEvent.new)
run faye_server
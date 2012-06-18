require 'heartbeat.rb'

class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    heartbeat_client = ThinHeartbeat::Status.new($redis)
    @rooms = Room.pending + Room.active
    if params[:users]
      @rooms = @rooms.each do |room|
        room.users = heartbeat_client.get_users_in_room(room.name)
      end
    end
  end

  def update
    @room = Room.find_by_name(params[:name])
    respond_with @room.update_attributes(params[:room])
  end
end

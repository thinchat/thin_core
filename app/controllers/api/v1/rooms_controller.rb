require 'heartbeat.rb'

class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    @rooms = Room.pending + Room.active + Room.closed
    if params[:users]
      @rooms = @rooms.each do |room|
        room.users = HEARTBEAT.get_users_in_room(room.name)
      end
    end
  end

  def update
    @room = Room.find_by_name(params[:name])
    respond_with @room.update_attributes(params[:room])
  end
end
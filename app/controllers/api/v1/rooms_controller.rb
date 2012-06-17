require 'heartbeat.rb'

class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    @rooms = Room.in_queue
    if params[:users]
      @rooms = @rooms.each do |room|
        room.users = ThinHeartbeat::Status.new('localhost').get_users_in_room(room.name)
      end
    end
  end

  def update
    respond_with Room.update(params[:id], params[:room])
  end
end
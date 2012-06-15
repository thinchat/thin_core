class RoomsController < ApplicationController
  def index
    @location = "Lobby"
  end

  def create
    # redirect_to rooms_path and return if current_user.class == Agent
    room = Room.create()
    redirect_to room_path(room.name)
  end

  def show
    @room = Room.where(name: params[:name].to_s).first
    redirect_to closed_room_path(@room, params) if @room.closed?
  end

  def closed
    @email = params[:email]
    @room = Room.where(name: params[:name].to_s).first
    redirect_to room_path(@room.name, params) unless @room.closed?
  end
end
class RoomsController < ApplicationController
  def index
    @user     = current_user
    @location = "Lobby"
  end

  def create
    # redirect_to rooms_path and return if current_user.class == Agent
    room = Room.create()
    redirect_to room_path(room)
  end

  def show
    @room     = Room.where(id: params[:id]).first
    if @room.status == "Closed"
      redirect_to closed_room_path(@room, params)
    end
  end

  def send_log
    @room   = Room.where(id: params[:id]).first
    email   = params[:log_email]
    room_id = params[:id]
    LogMailer.log_transcript(email, room_id).deliver
    redirect_to closed_room_path(@room, params)
  end

  def closed
    @room = Room.where(id: params[:id]).first
    @user = current_user
    unless @room.status == "Closed"
      redirect_to room_path(@room, params)
    end
  end
end
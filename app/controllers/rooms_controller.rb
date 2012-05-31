class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def create
    last_room = Room.order("id DESC").first
    number = last_room ? last_room.id + 1 : 1
    Room.create(name: "Room #{number}")
    redirect_to rooms_path
  end

  def show
    @room = Room.where(id: params[:id]).first
    @messages = @room.messages
  end

end

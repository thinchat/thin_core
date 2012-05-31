class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def create
    number = Room.order("id DESC").first.id + 1
    Room.create(name: "Room #{number}")
    redirect_to rooms_path
  end

  def show
    @room = Room.where(id: params[:id]).first
    @messages = @room.messages
  end

end

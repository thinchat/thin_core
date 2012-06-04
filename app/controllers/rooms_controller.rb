class RoomsController < ApplicationController

  def index
    @rooms = Room.all
    @session = cookies.signed[:user]

  end

  def create
    last_room = Room.order("id DESC").first
    number = last_room ? last_room.id + 1 : 1
    Room.create(name: "Room #{number}")
    redirect_to rooms_path
  end

  def show
    @room = Room.where(id: params[:id]).first
    @messages = @room.messages.last(MESSAGE_DISPLAY_COUNT)
    @display_name = current_user ? current_user.display_name : "Guest #{params[:id]}"
  end

  private

  def current_user
    @current_user ||= session["user"]
  end

end

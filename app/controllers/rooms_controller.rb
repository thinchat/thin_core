class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @user = current_user
  end

  def create
    # redirect_to rooms_path and return if current_user.class == Agent

    last_room = Room.order("id DESC").first
    name = Faker::Name.name
    room = Room.create(name: "The #{name}")
    redirect_to room_path(room)
  end

  def show
    @room = Room.where(id: params[:id]).first
    @messages = @room.messages.last(MESSAGE_DISPLAY_COUNT)
    @user = current_user
  end

end
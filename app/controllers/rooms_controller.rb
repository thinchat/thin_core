class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @user = current_user
  end

  def create
    redirect_to rooms_path and return if current_user.class == Agent

    last_room = Room.order("id DESC").first
    number = last_room ? last_room.id + 1 : 1
    room = Rooms.create(name: "Room #{number}")
    # broadcast("/messages/#{room.id}", Message.new(body: "#{room.name} created."))
    redirect_to room_path(room)
  end

  def show
    @room = Room.where(id: params[:id]).first
    @messages = @room.messages.last(MESSAGE_DISPLAY_COUNT)
    @user = current_user
  end

end

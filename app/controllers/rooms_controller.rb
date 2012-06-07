class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @user = current_user
  end

  def create
    redirect_to rooms_path and return if current_user.class == Agent

    guest = Guest.create
    last_room = Room.order("id DESC").first
    number = last_room ? last_room.id + 1 : 1
    room = guest.rooms.create(name: "Room #{number}")
    # broadcast("/messages/#{room.id}", Message.new(body: "#{room.name} created."))
    redirect_to room_path(room)
  end

  def show
    @room = Room.where(id: params[:id]).first
    @messages = @room.messages.last(MESSAGE_DISPLAY_COUNT)
    @session = cookies.signed[:guest]
    
    if current_user
      create_room_agent
      @user = current_user
    else
      @user = @room.guest
    end
  end

  private

  def create_room_agent
    return if (current_user.class == Guest) || @room.room_agents.where(thin_auth_id: current_user.thin_auth_id).first
    @room.room_agents.create(thin_auth_id: current_user.thin_auth_id)
  end
end

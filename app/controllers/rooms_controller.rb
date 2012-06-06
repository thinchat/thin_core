class RoomsController < ApplicationController

  def index
    @rooms = Room.all
    @user = current_user
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
    @user = current_user ? create_room_agent : Guest.create
  end

  private

  def create_room_agent
    @room.room_agents.create(thin_auth_id: current_user.thin_auth_id)
  end
end

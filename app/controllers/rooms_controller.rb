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
    if current_user
      create_room_agent
      @user = current_user
    else
      @user = Guest.create
    end
  end

  private

  def create_room_agent
    return if @room.room_agents.where(thin_auth_id: current_user.thin_auth_id).first
    @room.room_agents.create(thin_auth_id: current_user.thin_auth_id)
  end
end

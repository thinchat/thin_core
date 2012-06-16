class RoomsController < ApplicationController
  before_filter :require_login, :only => [:index]

  def index
    @location = "Lobby"
  end

  def create
    # redirect_to rooms_path and return if current_user.class == Agent
    if current_user.agent?
      room = Room.create()
    else
      room = current_user.rooms.create
    end
    redirect_to room_path(room.name)
  end

  def show
    if current_user.guest?
      @room = current_user.rooms.find_by_name(params[:name])
      @location = @room.name
    else
      @room = Room.find_by_name(params[:name])
      @location = @room.name
    end

    if @room.nil?
      redirect_to not_found_path
    elsif @room.closed?      
      redirect_to closed_room_path(@room.name, params)
    end
  end

  def closed
    @room = Room.where(name: params[:name].to_s).first
    @location = @room.name
    @email = params[:email]
    redirect_to room_path(@room.name, params) unless @room.closed?
  end
end
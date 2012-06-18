class RoomsController < ApplicationController
  # before_filter :require_login, :only => [:index]

  def new
    room = Room.build_for_user(current_user)
    redirect_to room_path(room.name) if room.save
  end

  def index
    @location = "Lobby"
  end

  def create
    room = Room.build_for_user(current_user)
    redirect_to room_path(room.name) if room.save
  end

  def show
    @room = Room.find_by_name_for_user(current_user, params[:name])
    redirect_to not_found_path and return if @room.nil?

    @location = @room.name
    redirect_to new_room_path if @room.closed?
  end

  def closed
    @room = Room.where(name: params[:name].to_s).first
    @location = @room.name
    @email = params[:email]
    redirect_to room_path(@room.name, params) unless @room.closed?
  end
end
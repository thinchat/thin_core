class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    @rooms = Room.in_queue
  end

  def update
    @room = Room.find_by_name(params[:name])
    respond_with @room.update_attributes(params[:room])
  end
end
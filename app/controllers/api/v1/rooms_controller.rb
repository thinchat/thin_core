class Api::V1::RoomsController < ApplicationController
  def show
    if @room = Room.where(id: params[:id].to_s).first
      render :json => @room.messages, :status => :found
    else
      render :json => {:error => "Room not found."}, :status => :not_found
    end
  end
end
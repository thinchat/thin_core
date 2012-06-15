class LogsController < ApplicationController
  def create
    room = Room.where(name: params[:name].to_s).first
    LogMailer.log_transcript(params[:email], room.id).deliver
    redirect_to closed_room_path(room.name, params)
  end
end

class Api::V1::MessagesController < ApplicationController
  respond_to :json

  def index
    if room = Room.where(id: params[:room_id].to_s).first
      @messages = room.messages
    else
      render :json => {:error => "Room not found."}, :status => :not_found
    end
  end

  def create
    params_hash = Message.build_params_hash(params["message"])
    message = Message.create!(params_hash)
    if message.message_type == "Subscribe" && message.user_type == "Agent"
      message.room.change_status
    end
    render :nothing => true, :status => 201 if message.broadcast
  end

end
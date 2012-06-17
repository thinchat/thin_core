require 'heartbeat.rb'

class GuestsController < ApplicationController

  def update
    @guest = Guest.find(params[:id])
    old_guest_name = @guest.name
    @guest.update_attributes(params[:guest])

    params_hash = { room_id: params[:room_id],
                     user_name: current_user.name,
                     user_id: current_user.id,
                     user_type: current_user.class.to_s,
                     message_type: "NameChange",
                     body: "#{old_guest_name} changed name to #{@guest.name}" }

    message = Message.new(params_hash)
    
    if message.in_room?
      Resque.enqueue(CreateMessageJob, params_hash)
      message.broadcast
    end

    render :json => true
  end
end
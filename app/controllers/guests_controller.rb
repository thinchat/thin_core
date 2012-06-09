require 'heartbeat.rb'

class GuestsController < ApplicationController

  def update
    @guest = Guest.find(params[:id])
    @guest.update_attributes(params[:guest])
    render :json => true
  end

  def index
    @users = ThinHeartbeat::Status.get_users
  end
end
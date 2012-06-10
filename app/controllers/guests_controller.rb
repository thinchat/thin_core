require 'heartbeat.rb'

class GuestsController < ApplicationController

  def update
    @guest = Guest.find(params[:id])
    @guest.update_attributes(params[:guest])
    render :json => true
  end

  def index
    password = Rails.env == 'production' ? REDIS_PASSWORD : nil
    status = ThinHeartbeat::Status.new(password)
    @users = status.get_users
  end
end
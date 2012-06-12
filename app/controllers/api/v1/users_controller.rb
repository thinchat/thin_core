require 'heartbeat.rb'

class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    password = Rails.env == 'production' ? REDIS_PASSWORD : nil
    @users = ThinHeartbeat::Status.new(REDIS_URL, password).get_users
    render :json => @users
  end
end
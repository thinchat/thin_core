require 'heartbeat.rb'

class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    heartbeat_client = ThinHeartbeat::Status.new(REDIS)
    @users = heartbeat_client.get_users
  end
end
require 'heartbeat.rb'

class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = ThinHeartbeat::Status.new(REDIS_URL, REDIS_PASSWORD).get_users
  end
end
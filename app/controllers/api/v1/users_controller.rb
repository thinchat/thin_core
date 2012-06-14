require 'heartbeat.rb'

class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = ThinHeartbeat::Status.new('localhost').get_users
  end
end
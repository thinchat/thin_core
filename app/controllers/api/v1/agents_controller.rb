require 'heartbeat.rb'

class Api::V1::AgentsController < ApplicationController
  respond_to :json

  def index
    @users = HEARTBEAT.get_agents
    if params[:rooms]
      @users = @users.each do |user|
        user.rooms = HEARTBEAT.get_users_in_room(room.name)
      end
    end
  end
end
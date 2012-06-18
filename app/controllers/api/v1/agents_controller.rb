require 'heartbeat.rb'

class Api::V1::AgentsController < ApplicationController
  respond_to :json

  def index
    heartbeat_client = ThinHeartbeat::Status.new(REDIS)
    @users = heartbeat_client.get_agents.uniq_by{ |user| user.user_id }
    if params[:rooms]
      @users = @users.each do |user|
        user.client_ids = heartbeat_client.get_rooms_for_user(user).collect do |room|
          room.client_id
        end
      end
    end
  end
end
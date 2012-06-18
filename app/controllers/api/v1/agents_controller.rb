require 'heartbeat.rb'

class Api::V1::AgentsController < ApplicationController
  respond_to :json

  def index
    heartbeat_client = ThinHeartbeat::Status.new($redis)
    @users = heartbeat_client.get_unique_agents.sort_by{ |user| user.user_name }
    if params[:rooms]
      @users = @users.each do |user|
        user.client_ids = heartbeat_client.get_client_ids_for_user(user)
      end
    end
  end
  
end
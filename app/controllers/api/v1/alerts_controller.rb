class Api::V1::AlertsController < ApplicationController
  def create
    requesting_agent = Hashie::Mash.new(params[:user_hash])
    requested_agent = Agent.new(params[:id], params[:email])
    Alert.notify_agent(requesting_agent, requested_agent, room_url(requesting_agent.location))
    render :json => true, :status => :ok
  end
end

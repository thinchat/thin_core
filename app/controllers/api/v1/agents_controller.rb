require 'heartbeat.rb'

class Api::V1::AgentsController < ApplicationController
  respond_to :json

  def index
    @users = ThinHeartbeat::Status.new('localhost').get_agents.uniq_by{ |agent| agent.id }
  end
end
require 'heartbeat.rb'

class AgentsController < ApplicationController
  before_filter :require_login, :only => [:index]

  def index
  end
end
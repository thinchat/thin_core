class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    render :json => Room.all, :status => :ok
  end
end
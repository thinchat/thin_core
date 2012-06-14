class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    @rooms = Room.all
  end

  def update
    respond_with Room.update(params[:id], params[:room])
  end

end
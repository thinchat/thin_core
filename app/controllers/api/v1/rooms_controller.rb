class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    @rooms = Room.all
  end
end
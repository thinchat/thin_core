class GuestsController < ApplicationController
  def update
    @guest = Guest.find(params[:id])
    @guest.update_attributes(params[:guest])
    render :json => true
  end
end
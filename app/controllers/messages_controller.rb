class MessagesController < ApplicationController

  respond_to :html, :json, :js

  def create
    if @message = Message.create!(params[:message])
    else
      render :json => @message.errors, :status => 500
    end
  end
end

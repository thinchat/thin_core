class MessagesController < ApplicationController

  respond_to :html, :json, :js

  def create
    unless @message = Message.create!(params[:message])
      render :json => @message.errors, :status => 500
    end
  end
end

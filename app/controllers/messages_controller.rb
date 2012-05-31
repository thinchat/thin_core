class MessagesController < ApplicationController

  respond_to :json, :js

  def index
    @messages = Message.all
    render :json => @messages
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create!(params[:message])
  end
end

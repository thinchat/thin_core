class MessagesController < ApplicationController

  respond_to :html, :json, :js

  def create
    if @message = Message.create!(params[:message])
      broadcast("/messages/#{@message.room_id}", @message)
      render :json => @message
    else
      render :json => @message.errors, :status => 500
    end
  end

  private

  def broadcast(channel, object)
    message = {:channel => channel, :data => { :object => object, :type => "message" } }
    uri = URI.parse("#{FAYE_URL}/faye")
    raise uri.inspect
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end

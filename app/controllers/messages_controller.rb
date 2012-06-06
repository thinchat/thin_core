class MessagesController < ApplicationController

  respond_to :html, :json, :js

  def create    
    params[:message].merge!(:thin_auth_id => current_user.thin_auth_id) if current_user

    if @message = Message.create!(params[:message])
      broadcast("/messages/#{@message.room_id}", @message)
      render :json => @message
    else
      render :json => @message.errors, :status => 500
    end
  end

  private

  def broadcast(channel, object)
    message = {:channel => channel, :data => { :display_name => object.display_name, :object => object, :type => "message" } }
    uri = URI.parse("#{FAYE_URL}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end

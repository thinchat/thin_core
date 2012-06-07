class MessagesController < ApplicationController

  respond_to :html, :json, :js

  def create    
    params[:message].merge!(current_user.user_hash)
    message = Message.create!(params[:message])
    broadcast("/messages/#{message.room_id}", message)
  end

  private

  def broadcast(channel, object)
    message = {:channel => channel, :data => { :user_name => object.user_name, :object => object, :type => "message" } }
    uri = URI.parse("#{FAYE_URL}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
    render :nothing => true, :status => 201
  end

end

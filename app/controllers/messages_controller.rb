class MessagesController < ApplicationController

  respond_to :html, :json, :js

  def create    
    params[:message].merge!(current_user.user_hash)
    message = Message.create!(params[:message])
    broadcast("/messages/#{message.room_id}", message.to_hash)
  end

  private

  def broadcast(channel, object)
    message = {:channel => channel, 
               :data => { :chat_message => object } }
                          
    uri = URI.parse("#{FAYE_URL}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
    REDIS.publish 'thinchat', message.to_json
    render :nothing => true, :status => 201
  end

end

# {"channel"=>"/messages/5", 
#  "data"=> { 
#             "object"=> { "user_name"=>"Jonan", 
#                          "user_id"=>1, 
#                          "user_type"=>"Guest", 
#                          "message_id"=>1, 
#                          "message_type"=>"Message", 
#                          "message_body"=>"I'm a whale.", 
#                          "metadata"=>{}, 
#                          "created_at"=>"2012-06-07T17:49:57Z" } } }